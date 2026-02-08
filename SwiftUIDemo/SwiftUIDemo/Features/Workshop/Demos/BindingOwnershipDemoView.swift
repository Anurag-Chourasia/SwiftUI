import SwiftUI

struct BindingOwnershipDemoView: View {

    // MARK: - State
    @State private var isNotificationsEnabled = false
    @State private var serverLog = "No server action yet"

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "@Binding is permission to read/write data, not a place for business logic."
                ) {
                    Text("Child reports user intent. Parent handles side effects.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Live Demo") {
                    ChildIntentView(
                        isOn: isNotificationsEnabled,
                        onToggle: handleToggle
                    )

                    Text("Server log: \(serverLog)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Bad vs Good") {
                    CodeSnippetView(code: badSnippet)
                    CodeSnippetView(code: goodSnippet)
                }
            }
            .padding()
        }
        .navigationTitle("Binding Ownership")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Actions
    private func handleToggle() {
        isNotificationsEnabled.toggle()
        serverLog = "Saved to server at \(Date.now.formatted(date: .omitted, time: .standard))"
    }

    // MARK: - Constants
    private let badSnippet = """
struct ChildView: View {
    @Binding var isOn: Bool

    func toggle() {
        isOn.toggle()
        saveToServer()
    }
}
"""

    private let goodSnippet = """
struct ChildView: View {
    let isOn: Bool
    let onToggle: () -> Void
}

ChildView(isOn: isOn) {
    isOn.toggle()
    saveToServer()
}
"""
}

private struct ChildIntentView: View {

    // MARK: - Inputs
    let isOn: Bool
    let onToggle: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(
                isOn ? "Notifications Enabled" : "Notifications Disabled",
                systemImage: isOn ? "bell.fill" : "bell.slash.fill"
            )
            .foregroundStyle(isOn ? .green : .orange)

            Button(isOn ? "Disable" : "Enable") {
                onToggle()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    NavigationView {
        BindingOwnershipDemoView()
    }
}
