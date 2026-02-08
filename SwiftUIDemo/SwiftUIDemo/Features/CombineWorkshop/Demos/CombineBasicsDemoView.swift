import SwiftUI
import Combine

struct CombineBasicsDemoView: View {

    // MARK: - State
    @State private var announcementText = ""
    @StateObject private var viewModel = CombineBasicsViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Publisher emits, operators transform, subscriber receives."
                ) {
                    Text("Send announcements and random numbers to see pipeline transformations.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Announcements Pipeline") {
                    TextField("Type an announcement", text: $announcementText)
                        .textFieldStyle(.roundedBorder)

                    HStack {
                        Button("Send") {
                            viewModel.sendAnnouncement(announcementText)
                            announcementText = ""
                        }
                        .buttonStyle(.borderedProminent)

                        Button("Push Random Number") {
                            viewModel.pushRandomNumber()
                        }
                        .buttonStyle(.bordered)
                    }

                    Text("Latest even number stream output: \(viewModel.latestEvenNumber)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Divider()

                    Text("Edited Messages")
                        .font(.subheadline.bold())

                    if viewModel.editedMessages.isEmpty {
                        Text("No events yet")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(Array(viewModel.editedMessages.enumerated()), id: \.offset) { _, message in
                            Text("• \(message)")
                                .font(.footnote)
                        }
                    }
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Publisher Basics")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
let announcements = PassthroughSubject<String, Never>()

announcements
    .map { "[Edited] \\($0)" }
    .sink { print($0) }
    .store(in: &cancellables)
"""
}

@MainActor
private final class CombineBasicsViewModel: ObservableObject {
    @Published private(set) var editedMessages: [String] = []
    @Published private(set) var latestEvenNumber = "None"

    private let announcements = PassthroughSubject<String, Never>()
    private let numbers = PassthroughSubject<Int, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        announcements
            .map { "[Edited] \($0)" }
            .sink { [weak self] message in
                self?.editedMessages.insert(message, at: 0)
            }
            .store(in: &cancellables)

        numbers
            .filter { $0.isMultiple(of: 2) }
            .map { "Even: \($0)" }
            .sink { [weak self] value in
                self?.latestEvenNumber = value
            }
            .store(in: &cancellables)
    }

    func sendAnnouncement(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        announcements.send(trimmed)
    }

    func pushRandomNumber() {
        numbers.send(Int.random(in: 1...20))
    }
}

#Preview {
    NavigationView {
        CombineBasicsDemoView()
    }
}
