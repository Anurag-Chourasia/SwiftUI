import SwiftUI
import Combine

struct DebouncedSearchDemoView: View {

    // MARK: - State
    @StateObject private var viewModel = DebouncedSearchViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Debounce waits for typing pause; removeDuplicates avoids repeated requests."
                ) {
                    Text("This matches Slide 15: Debounced Search.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Live Demo") {
                    TextField("Search fruits...", text: $viewModel.query)
                        .textFieldStyle(.roundedBorder)

                    if viewModel.isSearching {
                        ProgressView("Searching...")
                    }

                    if viewModel.results.isEmpty {
                        Text(viewModel.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Start typing to search" : "No results")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.results, id: \.self) { value in
                            Text("• \(value)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Debounced Search")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
$query
    .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
    .removeDuplicates()
    .flatMap { service.search(query: $0) }
    .sink { [weak self] in self?.results = $0 }
    .store(in: &cancellables)
"""
}

private struct DemoSearchService {
    let values = [
        "Apple", "Apricot", "Banana", "Blueberry", "Cherry",
        "Grape", "Kiwi", "Mango", "Orange", "Peach"
    ]

    func search(query: String) -> AnyPublisher<[String], Never> {
        guard !query.isEmpty else {
            return Just([]).eraseToAnyPublisher()
        }

        let result = values.filter { $0.localizedCaseInsensitiveContains(query) }

        return Just(result)
            .delay(for: .milliseconds(250), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

@MainActor
private final class DebouncedSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published private(set) var results: [String] = []
    @Published private(set) var isSearching = false

    private let service: DemoSearchService
    private var cancellables = Set<AnyCancellable>()

    init(service: DemoSearchService = DemoSearchService()) {
        self.service = service

        $query
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] text in
                self?.isSearching = !text.isEmpty
            })
            .flatMap { [service] text in
                service.search(query: text)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.results = result
                self?.isSearching = false
            }
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationView {
        DebouncedSearchDemoView()
    }
}
