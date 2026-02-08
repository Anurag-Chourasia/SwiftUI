import SwiftUI
import Combine

struct CounterStreamDemoView: View {

    // MARK: - State
    @StateObject private var viewModel = CounterStreamViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Convert button taps to streams, merge, then accumulate with scan."
                ) {
                    Text("This matches Slide 13: Counter Stream.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Live Demo") {
                    Text("Count: \(viewModel.count)")
                        .font(.system(size: 40, weight: .bold, design: .rounded))

                    HStack(spacing: 12) {
                        Button("-1") {
                            viewModel.decrement.send(())
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.red)

                        Button("+1") {
                            viewModel.increment.send(())
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.green)
                    }
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Counter Stream")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
Publishers.Merge(increment.map { 1 }, decrement.map { -1 })
    .scan(0, +)
    .assign(to: &$count)
"""
}

@MainActor
private final class CounterStreamViewModel: ObservableObject {
    @Published private(set) var count = 0

    let increment = PassthroughSubject<Void, Never>()
    let decrement = PassthroughSubject<Void, Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.Merge(increment.map { 1 }, decrement.map { -1 })
            .scan(0, +)
            .receive(on: DispatchQueue.main)
            .assign(to: &$count)
    }
}

#Preview {
    NavigationView {
        CounterStreamDemoView()
    }
}
