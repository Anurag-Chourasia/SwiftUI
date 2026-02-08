import SwiftUI
import Combine

struct APIStateFlowDemoView: View {

    // MARK: - State
    @StateObject private var viewModel = APIStateFlowViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "User action -> loading true -> pipeline -> success/error -> loading false."
                ) {
                    Toggle("Simulate next request failure", isOn: $viewModel.simulateFailure)

                    Button("Load Users") {
                        viewModel.loadUsers()
                    }
                    .buttonStyle(.borderedProminent)
                }

                SectionCard(title: "Live State") {
                    if viewModel.isLoading {
                        ProgressView("Loading users...")
                    } else if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.subheadline)
                            .foregroundStyle(.red)
                    } else if viewModel.users.isEmpty {
                        Text("No users yet")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(viewModel.users, id: \.self) { user in
                            Text("• \(user)")
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
        .navigationTitle("API State Flow")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
func loadUsers() {
    isLoading = true
    errorMessage = nil

    service.fetchUsers()
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: ..., receiveValue: ...)
        .store(in: &cancellables)
}
"""
}

private enum MockUsersServiceError: LocalizedError {
    case unavailable

    var errorDescription: String? {
        "Server temporarily unavailable. Try again."
    }
}

private struct MockUsersService {
    func fetchUsers(shouldFail: Bool) -> AnyPublisher<[String], Error> {
        if shouldFail {
            return Fail(error: MockUsersServiceError.unavailable)
                .delay(for: .milliseconds(700), scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        }

        let users = ["Anurag", "Priya", "Rohan", "Sara", "Karan"]

        return Just(users)
            .delay(for: .milliseconds(700), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

@MainActor
private final class APIStateFlowViewModel: ObservableObject {
    @Published private(set) var users: [String] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?
    @Published var simulateFailure = false

    private let service = MockUsersService()
    private var cancellables = Set<AnyCancellable>()

    func loadUsers() {
        isLoading = true
        errorMessage = nil

        service.fetchUsers(shouldFail: simulateFailure)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoading = false
                    if case let .failure(error) = completion {
                        self.users = []
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] users in
                    self?.users = users
                }
            )
            .store(in: &cancellables)
    }
}

#Preview {
    NavigationView {
        APIStateFlowDemoView()
    }
}
