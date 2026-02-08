import SwiftUI

struct DemoRow: View {

    // MARK: - Inputs
    let title: String
    let summary: String
    let systemImage: String

    // MARK: - Body
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)

                Text(summary)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    DemoRow(
        title: "Counter Stream",
        summary: "Merge tap streams and build running total.",
        systemImage: "plusminus"
    )
        .padding()
}
