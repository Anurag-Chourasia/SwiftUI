import SwiftUI
import Combine

struct StateOwnershipDemoView: View {

    // MARK: - State
    @State private var parentRedrawCount = 0
    @StateObject private var goodViewModel = OwnershipCounterViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "If the view creates a reference type, use @StateObject to keep it alive."
                ) {
                    Text("Tap Redraw Parent and compare both cards.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Live Demo") {
                    Button("Redraw Parent") {
                        parentRedrawCount += 1
                    }
                    .buttonStyle(.bordered)

                    Text("Parent redraws: \(parentRedrawCount)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    BadOwnershipExampleView(redrawCount: parentRedrawCount)
                    GoodOwnershipExampleView(redrawCount: parentRedrawCount, viewModel: goodViewModel)
                }

                SectionCard(title: "Bad vs Good") {
                    CodeSnippetView(code: badSnippet)
                    CodeSnippetView(code: goodSnippet)
                }
            }
            .padding()
        }
        .navigationTitle("State Ownership")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let badSnippet = """
struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
}
"""

    private let goodSnippet = """
struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
}
"""
}

private struct BadOwnershipExampleView: View {

    // MARK: - Inputs
    let redrawCount: Int

    // MARK: - State
    @ObservedObject var viewModel = OwnershipCounterViewModel()

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Bad: @ObservedObject created inside the view")
                .font(.subheadline.bold())
                .foregroundStyle(.red)

            Text("Parent redraw index: \(redrawCount)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Text("ViewModel ID: \(viewModel.instanceID)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Text("Count: \(viewModel.count)")
                .font(.headline)

            Button("Increment") {
                viewModel.count += 1
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding(12)
        .background(Color.red.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

private struct GoodOwnershipExampleView: View {

    // MARK: - Inputs
    let redrawCount: Int
    @ObservedObject var viewModel: OwnershipCounterViewModel

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Good: @StateObject owns the created object")
                .font(.subheadline.bold())
                .foregroundStyle(.green)

            Text("Parent redraw index: \(redrawCount)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Text("ViewModel ID: \(viewModel.instanceID)")
                .font(.footnote)
                .foregroundStyle(.secondary)

            Text("Count: \(viewModel.count)")
                .font(.headline)

            Button("Increment") {
                viewModel.count += 1
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }
        .padding(12)
        .background(Color.green.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

@MainActor
private final class OwnershipCounterViewModel: ObservableObject {
    @Published var count = 0
    let instanceID = String(UUID().uuidString.prefix(6))
}

#Preview {
    NavigationView {
        StateOwnershipDemoView()
    }
}
