import SwiftUI

struct ReusableModifierDemoView: View {

    // MARK: - State
    @State private var tapCount = 0

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "If style appears twice, extract once with a named modifier."
                ) {
                    Text("Total taps: \(tapCount)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Copy-Paste Styling") {
                    VStack(spacing: 10) {
                        Button("Login") { tapCount += 1 }
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        Button("Continue") { tapCount += 1 }
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                SectionCard(title: "Intent-Based Modifier") {
                    VStack(spacing: 10) {
                        Button("Login") { tapCount += 1 }
                            .primaryButton()

                        Button("Continue") { tapCount += 1 }
                            .primaryButton()
                    }
                }

                SectionCard(title: "Modifier Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Reusable Modifier")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
extension View {
    func primaryButton() -> some View {
        self
            .font(.headline)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
    }
}
"""
}

#Preview {
    NavigationView {
        ReusableModifierDemoView()
    }
}
