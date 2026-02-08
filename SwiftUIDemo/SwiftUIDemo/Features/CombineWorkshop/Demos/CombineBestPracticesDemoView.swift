import SwiftUI

struct CombineBestPracticesDemoView: View {

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Good Practices (Slide 20)",
                    subtitle: "Most production bugs are memory or threading mistakes."
                ) {
                    Text("• Store all subscriptions in `Set<AnyCancellable>`")
                    Text("• Use `[weak self]` in sink closures")
                    Text("• Use `receive(on: DispatchQueue.main)` before UI state updates")
                    Text("• Keep pipelines short and name intermediate methods")
                    Text("• Keep business logic in view model, not in view")
                }

                SectionCard(
                    title: "Rookie Mistakes",
                    subtitle: "Avoid these to keep code review and debugging simple."
                ) {
                    Text("• Retain cycles from strong self capture")
                    Text("• Giant unreadable chains with mixed responsibilities")
                    Text("• Overusing subjects for state that should be `@Published`")
                    Text("• Updating UI state from background thread")
                }

                SectionCard(title: "Reference Snippet") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Best Practices")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
publisher
    .receive(on: DispatchQueue.main)
    .sink { [weak self] value in
        self?.title = value
    }
    .store(in: &cancellables)
"""
}

#Preview {
    NavigationView {
        CombineBestPracticesDemoView()
    }
}
