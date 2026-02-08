import SwiftUI

struct WorkshopHubView: View {

    // MARK: - State
    @AppStorage("swiftui_level_one_completed") private var levelOneCompleted = false
    @AppStorage("swiftui_level_two_completed") private var levelTwoCompleted = false

    // MARK: - Body
    var body: some View {
        List {
            heroSection
            currentCampaignSection
            progressSection
            platformSection
            upcomingSection
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Learning Quest")
    }

    // MARK: - Subviews
    private var heroSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 8) {
                Text("SwiftUI Learning Game")
                    .font(.title2.bold())

                Text("Finish levels in order. Track your progress. Keep growing with upcoming tracks.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
    }

    private var currentCampaignSection: some View {
        Section("Current Levels") {
            NavigationLink(destination: WorkshopHomeView()) {
                LearningLevelCard(
                    level: "Level 1",
                    title: "SwiftUI: Writing It Right",
                    subtitle: "Ownership, modifiers, refactoring, and team standards.",
                    rewardXP: 100,
                    systemImage: "swift",
                    status: levelOneCompleted ? .completed : .available
                )
            }

            Button(levelOneCompleted ? "Reset Level 1" : "Mark Level 1 Complete") {
                levelOneCompleted.toggle()
                if !levelOneCompleted {
                    levelTwoCompleted = false
                }
            }
            .font(.subheadline)

            if levelOneCompleted {
                NavigationLink(destination: CombineWorkshopHomeView()) {
                    LearningLevelCard(
                        level: "Level 2",
                        title: "SwiftUI + Combine",
                        subtitle: "Streams, pipelines, validation, debounced search, and API flows.",
                        rewardXP: 150,
                        systemImage: "dot.radiowaves.left.and.right",
                        status: levelTwoCompleted ? .completed : .available
                    )
                }

                Button(levelTwoCompleted ? "Reset Level 2" : "Mark Level 2 Complete") {
                    levelTwoCompleted.toggle()
                }
                .font(.subheadline)
            } else {
                LearningLevelCard(
                    level: "Level 2",
                    title: "SwiftUI + Combine",
                    subtitle: "Unlock this level by completing Level 1 first.",
                    rewardXP: 150,
                    systemImage: "lock.shield",
                    status: .locked
                )
            }
        }
    }

    private var progressSection: some View {
        Section("Progress") {
            HStack {
                Label("XP", systemImage: "star.fill")
                Spacer()
                Text("\(earnedXP) / 250")
                    .foregroundStyle(.secondary)
            }

            ProgressView(value: progressValue)

            HStack {
                Label("Rank", systemImage: "flag.checkered")
                Spacer()
                Text(rankTitle)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var platformSection: some View {
        Section("Platform Availability Checks") {
            availabilityRow(title: "iOS 16", isAvailable: isIOS16Available)
            availabilityRow(title: "iOS 17", isAvailable: isIOS17Available)
            availabilityRow(title: "iOS 18", isAvailable: isIOS18Available)
            availabilityRow(title: "iOS 26", isAvailable: isIOS26Available)
        }
    }

    private var upcomingSection: some View {
        Section("Upcoming Future") {
            LearningLevelCard(
                level: "Level 3",
                title: "Swift Concurrency + SwiftUI",
                subtitle: "Async/await, task cancellation, and actor-safe UI updates.",
                rewardXP: 180,
                systemImage: "hourglass",
                status: .locked
            )

            LearningLevelCard(
                level: "Level 4",
                title: "Architecture, Testing, and Scaling",
                subtitle: "Feature modules, dependency injection, and production testing flows.",
                rewardXP: 220,
                systemImage: "building.2.crop.circle",
                status: .locked
            )
        }
    }

    @ViewBuilder
    private func availabilityRow(title: String, isAvailable: Bool) -> some View {
        HStack {
            Label(title, systemImage: "iphone")
            Spacer()
            Label(isAvailable ? "Available" : "Not Available", systemImage: isAvailable ? "checkmark.circle.fill" : "xmark.circle")
                .foregroundStyle(isAvailable ? .green : .secondary)
                .font(.subheadline)
        }
    }

    // MARK: - Helpers
    private var earnedXP: Int {
        var value = 0

        if levelOneCompleted {
            value += 100
        }

        if levelTwoCompleted {
            value += 150
        }

        return value
    }

    private var progressValue: Double {
        Double(earnedXP) / 250.0
    }

    private var rankTitle: String {
        switch earnedXP {
        case 250:
            return "SwiftUI Champion"
        case 100..<250:
            return "Pipeline Explorer"
        default:
            return "Rookie Builder"
        }
    }

    private var isIOS16Available: Bool {
        if #available(iOS 16.0, *) {
            return true
        }
        return false
    }

    private var isIOS17Available: Bool {
        if #available(iOS 17.0, *) {
            return true
        }
        return false
    }

    private var isIOS18Available: Bool {
        if #available(iOS 18.0, *) {
            return true
        }
        return false
    }

    private var isIOS26Available: Bool {
        if #available(iOS 26.0, *) {
            return true
        }
        return false
    }
}

#Preview {
    NavigationView {
        WorkshopHubView()
    }
}
