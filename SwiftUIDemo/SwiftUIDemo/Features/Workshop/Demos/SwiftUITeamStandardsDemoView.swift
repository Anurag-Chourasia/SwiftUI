import SwiftUI

struct SwiftUITeamStandardsDemoView: View {

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Mandatory Standards",
                    subtitle: "Use one predictable system so PRs focus on behavior, not formatting choices."
                ) {
                    Text("• View files follow one MARK layout")
                    Text("• Ownership is explicit (`@State`, `@Binding`, `@StateObject`)")
                    Text("• Styling duplication becomes a custom modifier")
                    Text("• Parent owns side effects and service calls")
                    Text("• Reusable components go in `Shared/`")
                    Text("• Avoid `AnyView` unless type-erasure is unavoidable")
                }

                SectionCard(
                    title: "PR Review Checklist",
                    subtitle: "Fast checks for regressions and maintainability."
                ) {
                    Text("• Is wrapper ownership correct?")
                    Text("• Are modifiers ordered layout -> color -> interaction?")
                    Text("• Does child UI avoid business logic?")
                    Text("• Is state scoped low enough?")
                    Text("• Are accessibility labels/hints clear?")
                }

                SectionCard(title: "File Template") {
                    CodeSnippetView(code: templateSnippet)
                }
            }
            .padding()
        }
        .navigationTitle("Team Standards")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let templateSnippet = """
struct ExampleView: View {

    // MARK: - Inputs
    let title: String

    // MARK: - State
    @State private var isActive = false

    // MARK: - Body
    var body: some View {
        content
    }

    // MARK: - Subviews
    private var content: some View {
        Text(title)
    }
}
"""
}

#Preview {
    NavigationView {
        SwiftUITeamStandardsDemoView()
    }
}
