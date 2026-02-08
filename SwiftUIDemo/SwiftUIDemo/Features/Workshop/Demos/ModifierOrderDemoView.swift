import SwiftUI

struct ModifierOrderDemoView: View {

    // MARK: - State
    @State private var paddingAmount: CGFloat = 16

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Modifier order changes behavior. Prefer: Layout -> Color -> Interaction."
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        Slider(value: $paddingAmount, in: 4...28, step: 1)
                        Text("Padding: \(Int(paddingAmount))")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                SectionCard(title: "Text.padding().background()") {
                    ExampleTile {
                        Text("Hello")
                            .font(.headline)
                            .padding(paddingAmount)
                            .background(Color.red.opacity(0.35))
                    }
                }

                SectionCard(title: "Text.background().padding()") {
                    ExampleTile {
                        Text("Hello")
                            .font(.headline)
                            .background(Color.red.opacity(0.35))
                            .padding(paddingAmount)
                    }
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Modifier Order")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
Text("Hello")
    .padding()
    .background(Color.red)

Text("Hello")
    .background(Color.red)
    .padding()
"""
}

private struct ExampleTile<Content: View>: View {

    // MARK: - Inputs
    private let content: Content

    // MARK: - Init
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    // MARK: - Body
    var body: some View {
        content
            .frame(maxWidth: .infinity, minHeight: 110)
            .background(Color(uiColor: .tertiarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.35), lineWidth: 1)
            )
    }
}

#Preview {
    NavigationView {
        ModifierOrderDemoView()
    }
}
