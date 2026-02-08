import SwiftUI

struct SwiftUIBasicsDemoView: View {

    // MARK: - State
    @State private var name = ""
    @State private var isEditing = false

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "SwiftUI Core Rule",
                    subtitle: "UI is a function of state. Views describe; state decides."
                ) {
                    VStack(alignment: .leading, spacing: 8) {
                        TextField("Enter your name", text: $name, onEditingChanged: { editing in
                            isEditing = editing
                        })
                        .textFieldStyle(.roundedBorder)

                        Text("Live output: Hello, \(name.isEmpty ? "Guest" : name)")
                            .font(.headline)

                        Text(isEditing ? "User is typing" : "Idle")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                }

                SectionCard(
                    title: "Mental Model",
                    subtitle: "Use this checklist before writing each view."
                ) {
                    Text("1. What data does this view read?")
                    Text("2. Who owns that data?")
                    Text("3. What user events should be bubbled up?")
                    Text("4. Which side effects belong in parent/view model?")
                    Text("5. What can be extracted as reusable style/subview?")
                }

                SectionCard(title: "Code Shape") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("SwiftUI Basics")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
struct ProfileHeaderView: View {
    let name: String

    var body: some View {
        Text(name)
    }
}

// Parent owns loading and side effects.
"""
}

#Preview {
    NavigationView {
        SwiftUIBasicsDemoView()
    }
}
