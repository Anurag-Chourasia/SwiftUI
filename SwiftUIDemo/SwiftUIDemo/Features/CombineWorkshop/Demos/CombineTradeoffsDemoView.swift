import SwiftUI

struct CombineTradeoffsDemoView: View {

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "When to Use Combine",
                    subtitle: "Best for ongoing streams and composed event pipelines."
                ) {
                    Text("• Search suggestions while typing")
                    Text("• Realtime form validation")
                    Text("• Event streams from notifications or UI subjects")
                    Text("• Multi-source state composition")
                }

                SectionCard(
                    title: "When Not to Use Combine",
                    subtitle: "Prefer async/await for simple one-shot request/response flows."
                ) {
                    Text("• Single profile fetch")
                    Text("• One-time settings update")
                    Text("• Simple sequential async operations")
                }

                SectionCard(
                    title: "Interview Framing",
                    subtitle: "Use this exact mental model in interviews."
                ) {
                    Text("`async/await` for finite tasks, `Combine` for continuous streams.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Comparison Snippet") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Tradeoffs")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
// One-shot task
func loadProfile() async throws -> Profile { ... }

// Continuous stream
func searchStream(query: String) -> AnyPublisher<[Item], Never> { ... }
"""
}

#Preview {
    NavigationView {
        CombineTradeoffsDemoView()
    }
}
