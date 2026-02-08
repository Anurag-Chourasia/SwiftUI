import SwiftUI
import Combine

struct URLSessionPostsDemoView: View {

    // MARK: - State
    @StateObject private var viewModel = URLSessionPostsViewModel()
    @State private var didLoad = false

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Map data, decode models, receive on main, then publish UI state."
                ) {
                    Button("Reload") {
                        viewModel.loadPosts()
                    }
                    .buttonStyle(.borderedProminent)
                }

                SectionCard(title: "Live Demo") {
                    if viewModel.isLoading {
                        ProgressView("Loading posts...")
                    } else if let errorMessage = viewModel.errorMessage {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Failed to load posts")
                                .font(.headline)

                            Text(errorMessage)
                                .font(.footnote)
                                .foregroundStyle(.secondary)

                            Button("Retry") {
                                viewModel.loadPosts()
                            }
                            .buttonStyle(.bordered)
                        }
                    } else {
                        ForEach(viewModel.posts) { post in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(post.title)
                                    .font(.subheadline)

                                Text("Post #\(post.id)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 8)

                            Divider()
                        }
                    }
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("URLSession + Combine")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            guard !didLoad else { return }
            didLoad = true
            viewModel.loadPosts()
        }
    }

    // MARK: - Constants
    private let snippet = """
URLSession.shared.dataTaskPublisher(for: url)
    .map(\\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())
    .receive(on: DispatchQueue.main)
    .sink(receiveCompletion: ..., receiveValue: ...)
    .store(in: &cancellables)
"""
}

private struct CombinePost: Decodable, Identifiable {
    let id: Int
    let title: String
}

@MainActor
private final class URLSessionPostsViewModel: ObservableObject {
    @Published private(set) var posts: [CombinePost] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func loadPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_limit=8") else {
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CombinePost].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoading = false
                    if case let .failure(error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] posts in
                    self?.posts = posts
                }
            )
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationView {
        URLSessionPostsDemoView()
    }
}
