import SwiftUI

struct CombineWorkshopHomeView: View {

    // MARK: - Inputs
    private let routes = CombineWorkshopRoute.allCases

    // MARK: - Body
    var body: some View {
        List {
            introSection

            ForEach(CombineWorkshopCategory.allCases) { category in
                Section(category.rawValue) {
                    ForEach(routesFor(category)) { route in
                        NavigationLink(destination: destination(for: route)) {
                            VStack(alignment: .leading, spacing: 6) {
                                DemoRow(
                                    title: route.title,
                                    summary: route.summary,
                                    systemImage: route.systemImage
                                )

                                Text(route.slideReference)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.leading, 36)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("SwiftUI + Combine")
    }

    // MARK: - Subviews
    private var introSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("Combine Workshop")
                    .font(.title3.bold())

                Text("Examples are directly mapped from swiftui-combine-slides.md demos and architecture guidance.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    // MARK: - Helpers
    private func routesFor(_ category: CombineWorkshopCategory) -> [CombineWorkshopRoute] {
        routes.filter { $0.category == category }
    }

    @ViewBuilder
    private func destination(for route: CombineWorkshopRoute) -> some View {
        switch route {
        case .publisherBasics:
            CombineBasicsDemoView()
        case .counterStream:
            CounterStreamDemoView()
        case .formValidation:
            FormValidationDemoView()
        case .debouncedSearch:
            DebouncedSearchDemoView()
        case .urlSessionRequest:
            URLSessionPostsDemoView()
        case .apiStateFlow:
            APIStateFlowDemoView()
        case .bestPractices:
            CombineBestPracticesDemoView()
        case .tradeoffsAndInterview:
            CombineTradeoffsDemoView()
        }
    }
}

#Preview {
    NavigationView {
        CombineWorkshopHomeView()
    }
}
