import SwiftUI

struct ViewBuilderDemoView: View {

    // MARK: - State
    @State private var isLoading = true
    @State private var requestCount = 1

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Use @ViewBuilder to split conditional UI into focused pieces."
                ) {
                    Button(isLoading ? "Finish Request" : "Start Request") {
                        isLoading.toggle()
                        requestCount += 1
                    }
                    .buttonStyle(.borderedProminent)

                    Text("Requests simulated: \(requestCount)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Status View") {
                    statusView
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(Color(uiColor: .tertiarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("@ViewBuilder")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Subviews
    @ViewBuilder
    private var statusView: some View {
        if isLoading {
            HStack(spacing: 10) {
                ProgressView()
                Text("Loading...")
                    .font(.headline)
            }
            .foregroundStyle(.blue)
        } else {
            Label("Done", systemImage: "checkmark.circle.fill")
                .font(.headline)
                .foregroundStyle(.green)
        }
    }

    // MARK: - Constants
    private let snippet = """
@ViewBuilder
var statusView: some View {
    if loading {
        ProgressView()
    } else {
        Text("Done")
    }
}
"""
}

#Preview {
    NavigationView {
        ViewBuilderDemoView()
    }
}
