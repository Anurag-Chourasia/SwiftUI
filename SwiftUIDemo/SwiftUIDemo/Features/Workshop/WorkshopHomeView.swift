import SwiftUI

struct WorkshopHomeView: View {

    // MARK: - Inputs
    private let routes = WorkshopRoute.allCases

    // MARK: - Body
    var body: some View {
        List {
            introSection

            ForEach(WorkshopCategory.allCases) { category in
                Section(category.rawValue) {
                    ForEach(routesFor(category)) { route in
                        NavigationLink(destination: destination(for: route)) {
                            DemoRow(
                                title: route.title,
                                summary: route.summary,
                                systemImage: route.systemImage
                            )
                        }
                    }
                }
            }
        }
        .navigationTitle("SwiftUI Team Workshop")
    }

    // MARK: - Subviews
    private var introSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("SwiftUI: Writing It Right")
                    .font(.title3.bold())

                Text("Live demos for ownership, modifiers, refactoring, and team structure.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    // MARK: - Helpers
    private func routesFor(_ category: WorkshopCategory) -> [WorkshopRoute] {
        routes.filter { $0.category == category }
    }

    @ViewBuilder
    private func destination(for route: WorkshopRoute) -> some View {
        switch route {
        case .basicsMentalModel:
            SwiftUIBasicsDemoView()
        case .stateOwnership:
            StateOwnershipDemoView()
        case .bindingOwnership:
            BindingOwnershipDemoView()
        case .modifierOrder:
            ModifierOrderDemoView()
        case .reusableModifier:
            ReusableModifierDemoView()
        case .viewBuilder:
            ViewBuilderDemoView()
        case .structureStandard:
            ViewStructureStandardDemoView()
        case .teamStandards:
            SwiftUITeamStandardsDemoView()
        }
    }
}

#Preview {
    NavigationView {
        WorkshopHomeView()
    }
}
