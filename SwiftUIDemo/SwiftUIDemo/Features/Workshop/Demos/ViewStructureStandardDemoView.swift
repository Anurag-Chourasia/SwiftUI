import SwiftUI

struct ViewStructureStandardDemoView: View {

    // MARK: - State
    @State private var isActive = false

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Use one predictable template for every SwiftUI file."
                ) {
                    Toggle("isActive", isOn: $isActive)
                }

                SectionCard(title: "Template") {
                    CodeSnippetView(code: structureSnippet)
                }

                SectionCard(title: "Applied Example") {
                    ExampleStructuredView(title: "Team Standard", isActive: isActive)
                }
            }
            .padding()
        }
        .navigationTitle("View Structure")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let structureSnippet = """
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

private struct ExampleStructuredView: View {

    // MARK: - Inputs
    let title: String
    let isActive: Bool

    // MARK: - Body
    var body: some View {
        content
    }

    // MARK: - Subviews
    private var content: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(isActive ? "Active" : "Inactive")
                .font(.subheadline)
                .foregroundStyle(isActive ? .green : .secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color(uiColor: .tertiarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    NavigationView {
        ViewStructureStandardDemoView()
    }
}
