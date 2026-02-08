import SwiftUI

enum LearningLevelStatus {
    case available
    case completed
    case locked

    var label: String {
        switch self {
        case .available:
            return "Available"
        case .completed:
            return "Completed"
        case .locked:
            return "Locked"
        }
    }

    var systemImage: String {
        switch self {
        case .available:
            return "play.circle.fill"
        case .completed:
            return "checkmark.circle.fill"
        case .locked:
            return "lock.fill"
        }
    }

    var tintColor: Color {
        switch self {
        case .available:
            return .blue
        case .completed:
            return .green
        case .locked:
            return .secondary
        }
    }
}

struct LearningLevelCard: View {

    // MARK: - Inputs
    let level: String
    let title: String
    let subtitle: String
    let rewardXP: Int
    let systemImage: String
    let status: LearningLevelStatus

    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                Label(level, systemImage: systemImage)
                    .font(.headline)
                    .foregroundStyle(status.tintColor)

                Spacer()

                Label(status.label, systemImage: status.systemImage)
                    .font(.caption.bold())
                    .foregroundStyle(status.tintColor)
            }

            Text(title)
                .font(.title3.bold())

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text("Reward: \(rewardXP) XP")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(uiColor: .secondarySystemBackground))
        )
    }
}

#Preview {
    LearningLevelCard(
        level: "Level 1",
        title: "SwiftUI: Writing It Right",
        subtitle: "Ownership, standards, and refactoring patterns.",
        rewardXP: 100,
        systemImage: "swift",
        status: .available
    )
    .padding()
}
