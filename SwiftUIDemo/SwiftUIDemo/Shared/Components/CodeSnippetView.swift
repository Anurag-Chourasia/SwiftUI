import SwiftUI

struct CodeSnippetView: View {

    // MARK: - Inputs
    let code: String

    // MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(code)
                .font(.system(.footnote, design: .monospaced))
                .foregroundStyle(Color(uiColor: .label))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(uiColor: .tertiarySystemBackground))
                )
        }
    }
}

#Preview {
    CodeSnippetView(code: "Text(\"Hello\")\\n    .padding()")
        .padding()
}
