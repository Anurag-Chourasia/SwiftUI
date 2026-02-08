import Foundation

enum WorkshopCategory: String, CaseIterable, Identifiable {
    case fundamentals = "SwiftUI Fundamentals"
    case ownership = "Ownership & Data Flow"
    case composition = "Composition & Modifiers"
    case structure = "Structure & Team Rules"

    var id: String { rawValue }
}

enum WorkshopRoute: String, CaseIterable, Hashable, Identifiable {
    case basicsMentalModel
    case stateOwnership
    case bindingOwnership
    case modifierOrder
    case reusableModifier
    case viewBuilder
    case structureStandard
    case teamStandards

    var id: String { rawValue }

    var title: String {
        switch self {
        case .basicsMentalModel:
            return "SwiftUI Basics Mental Model"
        case .stateOwnership:
            return "State Ownership"
        case .bindingOwnership:
            return "Binding Ownership"
        case .modifierOrder:
            return "Modifier Order"
        case .reusableModifier:
            return "Reusable Modifier"
        case .viewBuilder:
            return "@ViewBuilder Cleanup"
        case .structureStandard:
            return "View Structure Standard"
        case .teamStandards:
            return "Team Standards Checklist"
        }
    }

    var summary: String {
        switch self {
        case .basicsMentalModel:
            return "Understand one-way data flow and SwiftUI view responsibility."
        case .stateOwnership:
            return "Use @StateObject when the view creates and owns a reference type."
        case .bindingOwnership:
            return "Child reports intent, parent owns side effects."
        case .modifierOrder:
            return "Layout before color gives predictable visual output."
        case .reusableModifier:
            return "Extract repeated styling into a named intent."
        case .viewBuilder:
            return "Move conditional rendering into focused sections."
        case .structureStandard:
            return "Keep one predictable file template for team velocity."
        case .teamStandards:
            return "Foldering, naming, accessibility, testing, and review rules."
        }
    }

    var systemImage: String {
        switch self {
        case .basicsMentalModel:
            return "lightbulb"
        case .stateOwnership:
            return "person.crop.square"
        case .bindingOwnership:
            return "link"
        case .modifierOrder:
            return "square.stack.3d.up"
        case .reusableModifier:
            return "paintbrush.pointed"
        case .viewBuilder:
            return "rectangle.3.group"
        case .structureStandard:
            return "checklist"
        case .teamStandards:
            return "checkmark.seal"
        }
    }

    var category: WorkshopCategory {
        switch self {
        case .basicsMentalModel:
            return .fundamentals
        case .stateOwnership, .bindingOwnership:
            return .ownership
        case .modifierOrder, .reusableModifier, .viewBuilder:
            return .composition
        case .structureStandard, .teamStandards:
            return .structure
        }
    }
}
