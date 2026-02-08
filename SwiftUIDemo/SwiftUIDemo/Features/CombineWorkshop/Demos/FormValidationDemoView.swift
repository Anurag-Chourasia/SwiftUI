import SwiftUI
import Combine

struct FormValidationDemoView: View {

    // MARK: - State
    @StateObject private var viewModel = FormValidationViewModel()

    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                SectionCard(
                    title: "Rule",
                    subtitle: "Use CombineLatest to derive canSubmit from field streams."
                ) {
                    Text("This matches Slide 14: Form Validation.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Live Demo") {
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(.roundedBorder)

                    if let emailError = viewModel.emailError {
                        Text(emailError)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }

                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(.roundedBorder)

                    if let passwordError = viewModel.passwordError {
                        Text(passwordError)
                            .font(.footnote)
                            .foregroundStyle(.red)
                    }

                    Button("Sign In") {
                        viewModel.submit()
                    }
                    .primaryButton()
                    .disabled(!viewModel.canSubmit)
                    .opacity(viewModel.canSubmit ? 1 : 0.5)

                    Text(viewModel.statusMessage)
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                SectionCard(title: "Code") {
                    CodeSnippetView(code: snippet)
                }
            }
            .padding()
        }
        .navigationTitle("Form Validation")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Constants
    private let snippet = """
Publishers.CombineLatest($email, $password)
    .map { $0.contains("@") && $1.count >= 8 }
    .removeDuplicates()
    .assign(to: &$canSubmit)
"""
}

@MainActor
private final class FormValidationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""

    @Published private(set) var emailError: String?
    @Published private(set) var passwordError: String?
    @Published private(set) var canSubmit = false
    @Published private(set) var statusMessage = "Fill both fields"

    private var cancellables = Set<AnyCancellable>()

    init() {
        $email
            .map(Self.validateEmail)
            .removeDuplicates(by: ==)
            .receive(on: DispatchQueue.main)
            .assign(to: &$emailError)

        $password
            .map(Self.validatePassword)
            .removeDuplicates(by: ==)
            .receive(on: DispatchQueue.main)
            .assign(to: &$passwordError)

        Publishers.CombineLatest($email, $password)
            .map { email, password in
                Self.validateEmail(email) == nil && Self.validatePassword(password) == nil
            }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .assign(to: &$canSubmit)
    }

    func submit() {
        statusMessage = canSubmit ? "Form valid. Submit intent triggered." : "Form invalid."
    }

    private static func validateEmail(_ value: String) -> String? {
        guard value.contains("@"), value.contains(".") else {
            return "Enter a valid email"
        }
        return nil
    }

    private static func validatePassword(_ value: String) -> String? {
        guard value.count >= 8 else {
            return "Password must be at least 8 characters"
        }
        return nil
    }
}

#Preview {
    NavigationView {
        FormValidationDemoView()
    }
}
