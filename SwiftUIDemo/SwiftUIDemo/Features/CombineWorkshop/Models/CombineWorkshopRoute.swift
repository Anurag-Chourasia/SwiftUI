import Foundation

enum CombineWorkshopCategory: String, CaseIterable, Identifiable {
    case fundamentals = "Fundamentals"
    case liveDemos = "Live Demos"
    case production = "Production Patterns"

    var id: String { rawValue }
}

enum CombineWorkshopRoute: String, CaseIterable, Hashable, Identifiable {
    case publisherBasics
    case counterStream
    case formValidation
    case debouncedSearch
    case urlSessionRequest
    case apiStateFlow
    case bestPractices
    case tradeoffsAndInterview

    var id: String { rawValue }

    var title: String {
        switch self {
        case .publisherBasics:
            return "Publisher / Subscriber / Operator"
        case .counterStream:
            return "Counter Stream"
        case .formValidation:
            return "Form Validation"
        case .debouncedSearch:
            return "Debounced Search"
        case .urlSessionRequest:
            return "URLSession + Combine"
        case .apiStateFlow:
            return "Loading / Error / Success Flow"
        case .bestPractices:
            return "Best Practices & Mistakes"
        case .tradeoffsAndInterview:
            return "Tradeoffs + Interview Thinking"
        }
    }

    var summary: String {
        switch self {
        case .publisherBasics:
            return "Use subjects and operators to transform event streams."
        case .counterStream:
            return "Merge tap streams and build running state with scan."
        case .formValidation:
            return "CombineLatest drives form readiness automatically."
        case .debouncedSearch:
            return "Debounce and removeDuplicates reduce API noise."
        case .urlSessionRequest:
            return "Map, decode, receive on main, then update UI state."
        case .apiStateFlow:
            return "Standard MVVM pipeline for loading, error, and data."
        case .bestPractices:
            return "Weak self, main-thread updates, and readable pipelines."
        case .tradeoffsAndInterview:
            return "When Combine wins, when async/await is simpler."
        }
    }

    var systemImage: String {
        switch self {
        case .publisherBasics:
            return "dot.radiowaves.left.and.right"
        case .counterStream:
            return "plusminus"
        case .formValidation:
            return "checkmark.shield"
        case .debouncedSearch:
            return "magnifyingglass"
        case .urlSessionRequest:
            return "network"
        case .apiStateFlow:
            return "arrow.triangle.2.circlepath"
        case .bestPractices:
            return "checklist.checked"
        case .tradeoffsAndInterview:
            return "scalemass"
        }
    }

    var category: CombineWorkshopCategory {
        switch self {
        case .publisherBasics:
            return .fundamentals
        case .counterStream, .formValidation, .debouncedSearch, .urlSessionRequest:
            return .liveDemos
        case .apiStateFlow, .bestPractices, .tradeoffsAndInterview:
            return .production
        }
    }

    var slideReference: String {
        switch self {
        case .publisherBasics:
            return "Slides 6-8"
        case .counterStream:
            return "Slide 13"
        case .formValidation:
            return "Slide 14"
        case .debouncedSearch:
            return "Slide 15"
        case .urlSessionRequest:
            return "Slide 16"
        case .apiStateFlow:
            return "Slide 11"
        case .bestPractices:
            return "Slide 20"
        case .tradeoffsAndInterview:
            return "Slides 18, 19, 21"
        }
    }
}
