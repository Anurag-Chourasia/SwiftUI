# SwiftUI + Combine (iOS 15+) — 1-Hour Beginner Presentation

## Session Goal
Teach SwiftUI + Combine from zero knowledge with practical, production-friendly examples.

## Audience
- Junior to mid-level iOS developers
- SwiftUI basics known
- Combine beginner level

## Compatibility
- Swift 5+
- iOS 15+
- All demos use iOS 15-compatible APIs

---

## Slide 1 — Title (1 min)
### On Slide
- SwiftUI + Combine
- From zero to practical

### What to Say
- "Today we will learn Combine in the simplest way possible."
- "We will focus on practical app usage, not theory overload."

### Code Example
```swift
import SwiftUI

@main
struct CombineWorkshopApp: App {
    var body: some Scene {
        WindowGroup {
            Text("SwiftUI + Combine")
        }
    }
}
```

### Real-World Connection
- Every app has data that changes over time.
- Today we learn how to handle that cleanly.

---

## Slide 2 — Agenda (1 min)
### On Slide
- What Combine is
- Core concepts
- SwiftUI integration
- Live coding
- Best practices
- Interview Q&A

### What to Say
- "We will move from basic meaning to real app patterns."

### Code Example
```swift
enum SessionPart: String, CaseIterable {
    case basics = "Basics"
    case concepts = "Core Concepts"
    case integration = "SwiftUI Integration"
    case demos = "Live Demos"
    case practices = "Best Practices"
    case interview = "Interview Q&A"
}
```

### Real-World Connection
- This mirrors real onboarding: concept first, feature implementation next.

---

## Slide 3 — What Is Combine? (2 min)
### On Slide
- Combine listens to changing values
- It lets your UI react automatically
- Great for streams: typing, timers, live updates

### What to Say
- "Combine is Apple’s tool for handling values that change over time."
- "If data changes, your UI can update automatically."

### Code Example
```swift
import Combine

let publisher = Just("Hello Combine")
let cancellable = publisher
    .sink { value in
        print("Received:", value)
    }
```

### Real-World Connection
- Typing in a search bar is a value stream.
- Stock price updates are a value stream.

---

## Slide 4 — Why Combine Exists (2 min)
### On Slide
- Avoid callback nesting
- Avoid repeated UI state code
- Handle multiple async events cleanly

### What to Say
- "Without Combine, async code can become scattered and repetitive."
- "Combine gives us one data pipeline instead of many disconnected updates."

### Code Example
```swift
// Callback style (can become nested with more steps)
func loadWithCallback(completion: @escaping (Result<String, Error>) -> Void) {
    completion(.success("Data"))
}

// Combine style (declarative pipeline)
func loadWithCombine() -> AnyPublisher<String, Error> {
    Just("Data")
        .setFailureType(to: Error.self)
        .eraseToAnyPublisher()
}
```

### Real-World Connection
- In list screens, loading/error/success logic repeats often.
- Combine centralizes that logic in one place.

---

## Slide 5 — Combine vs Other Approaches (2 min)
### On Slide
- Callbacks: simple start, messy at scale
- Delegation: one-to-one communication
- Async/await: best for one-shot tasks
- Combine: best for ongoing streams

### What to Say
- "Use async/await when you fetch once and finish."
- "Use Combine when values keep changing."

### Code Example
```swift
protocol LoginDelegate: AnyObject {
    func loginDidFinish(success: Bool)
}

func loginAsync() async throws -> String {
    "token"
}

func loginStream() -> AnyPublisher<Bool, Never> {
    Just(true).eraseToAnyPublisher()
}
```

### Real-World Connection
- Login button tap: async/await is usually enough.
- Real-time notifications: Combine fits better.

---

## Slide 6 — Beginner Analogy (2 min)
### On Slide
- Publisher = speaker
- Subscriber = listener
- Operator = editor
- AnyCancellable = active listening pass

### What to Say
- "Think of Combine like a radio system."
- "Someone sends messages, someone listens, and rules can transform messages."

### Code Example
```swift
import Combine

let announcements = PassthroughSubject<String, Never>()
let pass = announcements
    .map { "[Edited] \($0)" }
    .sink { print($0) }

announcements.send("Session starts")
```

### Real-World Connection
- Push notification arrives -> message is transformed -> UI banner shows text.

---

## Slide 7 — Publisher, Subscriber, Operator (3 min)
### On Slide
- Publisher emits values over time
- Subscriber receives values and completion
- Operators transform values (`map`, `filter`, `debounce`)

### What to Say
- "Publisher sends values."
- "Subscriber receives values."
- "Operator changes values between source and destination."

### Code Example
```swift
import Combine

let numbers = [1, 2, 3, 4, 5].publisher

let cancellable = numbers
    .filter { $0 % 2 == 0 }
    .map { "Even: \($0)" }
    .sink { print($0) }
```

### Real-World Connection
- Filter only active users from API response, then format names for UI.

---

## Slide 8 — Subscription, AnyCancellable, @Published, Subjects (3 min)
### On Slide
- `sink` or `assign` starts subscription
- Store `AnyCancellable` to keep stream alive
- `@Published` emits updates automatically
- `PassthroughSubject` vs `CurrentValueSubject`

### What to Say
- "Common beginner bug: forgetting to store cancellables."
- "`PassthroughSubject` emits events only."
- "`CurrentValueSubject` also stores current value."

### Code Example
```swift
import Combine

final class CounterStore: ObservableObject {
    @Published var count = 0

    let taps = PassthroughSubject<Void, Never>()
    let selectedTab = CurrentValueSubject<Int, Never>(0)

    private var cancellables = Set<AnyCancellable>()

    init() {
        taps
            .sink { [weak self] in self?.count += 1 }
            .store(in: &cancellables)
    }
}
```

### Real-World Connection
- Tap events: `PassthroughSubject`.
- Current selected filter: `CurrentValueSubject`.

---

## Slide 9 — SwiftUI Integration Mental Model (4 min)
### On Slide
- View: render UI and send user actions
- ViewModel: logic, state, and Combine pipelines
- State changes (`@Published`) drive UI updates

### What to Say
- "Keep business logic out of Views."
- "ViewModel owns pipelines and exposes clean UI state."

### Code Example
```swift
import SwiftUI

final class GreetingViewModel: ObservableObject {
    @Published var name = ""
}

struct GreetingView: View {
    @StateObject private var viewModel = GreetingViewModel()

    var body: some View {
        VStack {
            TextField("Name", text: $viewModel.name)
            Text("Hello, \(viewModel.name)")
        }
        .padding()
    }
}
```

### Real-World Connection
- Profile edit screen updates preview text as user types.

---

## Slide 10 — MVVM Responsibilities (4 min)
### On Slide
- ViewModel manages:
- loading state
- error state
- result state
- user intent methods

### What to Say
- "Typical ViewModel has `isLoading`, `errorMessage`, and data list."
- "This gives predictable UI states."

### Code Example
```swift
import Combine

final class ProductsViewModel: ObservableObject {
    @Published private(set) var products: [String] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    func loadProducts() {
        // User intent method
    }
}
```

### Real-World Connection
- Same shape works for users, orders, transactions, and notifications screens.

---

## Slide 11 — Real API Flow (3 min)
### On Slide
- User action -> loading true
- API pipeline starts
- Success updates data
- Failure updates error
- loading false

### What to Say
- "This is the most reusable Combine screen pattern in production."

### Code Example
```swift
func loadUsers() {
    isLoading = true
    errorMessage = nil

    service.fetchUsers()
        .receive(on: DispatchQueue.main)
        .sink(
            receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            },
            receiveValue: { [weak self] users in
                self?.users = users
            }
        )
        .store(in: &cancellables)
}
```

### Real-World Connection
- This exact pattern is used in most feed/list pages.

---

## Slide 12 — Live Coding Setup (1 min)
### On Slide
- Demo 1: Counter
- Demo 2: Form validation
- Demo 3: Debounced search
- Demo 4: URLSession request

### What to Say
- "Each demo adds one practical skill."

### Code Example
```swift
import SwiftUI

struct DemoMenuView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Demo 1: Counter")
                Text("Demo 2: Validation")
                Text("Demo 3: Debounced Search")
                Text("Demo 4: Network")
            }
            .navigationTitle("Combine Demos")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
```

### Real-World Connection
- Useful for internal workshops and onboarding demo apps.

---

## Slide 13 — Demo 1: Counter Stream (2.5 min)
### On Slide
- Button taps become event streams
- Merge increment/decrement streams
- `scan` builds running total

### What to Say
- "This demo builds stream thinking from a very simple UI."

### Code Example
```swift
import SwiftUI
import Combine

final class CounterDemoVM: ObservableObject {
    @Published private(set) var count = 0
    let increment = PassthroughSubject<Void, Never>()
    let decrement = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.Merge(increment.map { 1 }, decrement.map { -1 })
            .scan(0, +)
            .assign(to: &$count)
    }
}
```

### Real-World Connection
- Quantity stepper in cart screens (+/- item count).

---

## Slide 14 — Demo 2: Form Validation (2.5 min)
### On Slide
- `@Published email/password`
- `combineLatest` for form validity
- Button enable state updates automatically

### What to Say
- "No manual checking after each keystroke."

### Code Example
```swift
import Combine

final class LoginVM: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published private(set) var canSubmit = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.CombineLatest($email, $password)
            .map { $0.contains("@") && $1.count >= 8 }
            .removeDuplicates()
            .assign(to: &$canSubmit)
    }
}
```

### Real-World Connection
- Signup screen: instantly show when form is ready.

---

## Slide 15 — Demo 3: Debounced Search (2.5 min)
### On Slide
- `debounce` waits for user pause
- `removeDuplicates` avoids repeated requests
- `flatMap` runs search pipeline

### What to Say
- "This prevents API spam and improves UX."

### Code Example
```swift
import Combine

$query
    .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
    .removeDuplicates()
    .flatMap { query in
        service.search(query: query)
    }
    .receive(on: DispatchQueue.main)
    .sink { [weak self] in self?.results = $0 }
    .store(in: &cancellables)
```

### Real-World Connection
- E-commerce search suggestions.
- Contact picker search.

---

## Slide 16 — Demo 4: URLSession + Combine (2.5 min)
### On Slide
- `dataTaskPublisher`
- `decode`
- `receive(on: .main)`
- update UI state

### What to Say
- "Always move UI updates to main thread."

### Code Example
```swift
import Combine

URLSession.shared.dataTaskPublisher(for: url)
    .map(\.data)
    .decode(type: [Post].self, decoder: JSONDecoder())
    .receive(on: DispatchQueue.main)
    .sink(
        receiveCompletion: { _ in },
        receiveValue: { [weak self] posts in
            self?.posts = posts
        }
    )
    .store(in: &cancellables)
```

### Real-World Connection
- News feed, notifications list, products catalog.

---

## Slide 17 — Real-World Use Cases (4 min)
### On Slide
- Search suggestions
- Login forms
- Pagination
- Data sync
- Event streams

### What to Say
- "Use Combine when data is changing continuously."

### Code Example
```swift
// Pagination trigger when last row appears
func loadNextPageIfNeeded(currentItem: Item) {
    guard currentItem.id == items.last?.id else { return }
    page += 1
    loadPage(page)
}

// Event stream example
NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
    .sink { _ in print("App became active") }
    .store(in: &cancellables)
```

### Real-World Connection
- Social feed infinite scrolling.
- Auto-refresh when app becomes active.

---

## Slide 18 — Pros and Cons (4 min)
### On Slide
- Pros: declarative flow, composability, MVVM fit
- Cons: learning curve, debugging complexity, overuse risk

### What to Say
- "Combine is powerful, but not required for every async task."

### Code Example
```swift
// Clean pipeline (pro)
$email
    .map { $0.trimmingCharacters(in: .whitespaces) }
    .removeDuplicates()
    .assign(to: &$cleanEmail)

// Overcomplicated pipeline (con) should be split into methods
```

### Real-World Connection
- Teams with shared patterns benefit a lot.
- Teams with no conventions can create hard-to-read pipelines.

---

## Slide 19 — Limitations and When Not To Use (4 min)
### On Slide
- Long pipelines can hurt readability
- Error handling can get verbose
- Over-publishing can impact performance
- Prefer async/await for single request-response

### What to Say
- "Pick tools by problem shape, not by trend."

### Code Example
```swift
// Better with async/await for one-shot fetch
func loadProfile() async {
    do {
        profile = try await service.fetchProfile()
    } catch {
        errorMessage = error.localizedDescription
    }
}
```

### Real-World Connection
- Profile detail page opened once: async/await is usually simpler.

---

## Slide 20 — Good Practices vs Rookie Mistakes (7 min)
### On Slide
- Good practices:
- Store cancellables
- Use `[weak self]`
- Keep logic in ViewModel
- Use `receive(on:)` for UI
- Keep pipelines small

- Rookie mistakes:
- Retain cycles
- Overusing subjects
- Business logic in Views
- Huge unreadable pipelines

### What to Say
- "Most real bugs are memory and threading mistakes."

### Code Example
```swift
publisher
    .receive(on: DispatchQueue.main)
    .sink { [weak self] value in
        self?.title = value
    }
    .store(in: &cancellables)
```

### Real-World Connection
- Prevents common crashes and memory leaks in production apps.

---

## Slide 21 — Interview Questions (4 min)
### On Slide
- What is Publisher/Subscriber?
- Why AnyCancellable?
- Subject differences?
- Combine vs async/await?

### What to Say
- "Interviewers want clear thinking and trade-offs, not only definitions."

### Code Example
```swift
func answerCombineVsAsyncAwait() -> String {
    "Use async/await for one-shot tasks, Combine for continuous streams."
}
```

### Real-World Connection
- This exact trade-off answer is often expected in iOS interviews.

---

## Slide 22 — Closing (1 min)
### On Slide
- Start with 3 patterns:
- validation
- debounced search
- loading/error state pipelines

### What to Say
- "Start small, practice often, then scale to bigger pipelines."

### Code Example
```swift
struct NextSteps {
    let steps = [
        "Build a validated login form",
        "Build a debounced search",
        "Build a loading/error list screen"
    ]
}
```

### Real-World Connection
- These three patterns cover a large part of everyday app work.

---

## Appendix — Full iOS 15+ Demo Code

### Demo 1: Counter
```swift
import SwiftUI
import Combine

final class CounterCombineViewModel: ObservableObject {
    @Published private(set) var count: Int = 0

    let incrementTapped = PassthroughSubject<Void, Never>()
    let decrementTapped = PassthroughSubject<Void, Never>()

    private var cancellables = Set<AnyCancellable>()

    init() {
        Publishers.Merge(
            incrementTapped.map { 1 },
            decrementTapped.map { -1 }
        )
        .scan(0, +)
        .receive(on: DispatchQueue.main)
        .assign(to: &$count)
    }
}

struct CounterCombineView: View {
    @StateObject private var viewModel = CounterCombineViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Count: \(viewModel.count)")
                .font(.largeTitle)

            HStack(spacing: 24) {
                Button("-1") { viewModel.decrementTapped.send(()) }
                Button("+1") { viewModel.incrementTapped.send(()) }
            }
        }
        .padding()
    }
}
```

### Demo 2: Form Validation
```swift
import SwiftUI
import Combine

final class LoginValidationViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    @Published private(set) var emailError: String?
    @Published private(set) var passwordError: String?
    @Published private(set) var canSubmit: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $email
            .map(Self.validateEmail)
            .receive(on: DispatchQueue.main)
            .assign(to: &$emailError)

        $password
            .map(Self.validatePassword)
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

struct LoginValidationView: View {
    @StateObject private var viewModel = LoginValidationViewModel()

    var body: some View {
        Form {
            TextField("Email", text: $viewModel.email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)

            if let error = viewModel.emailError {
                Text(error).foregroundColor(.red)
            }

            SecureField("Password", text: $viewModel.password)

            if let error = viewModel.passwordError {
                Text(error).foregroundColor(.red)
            }

            Button("Sign In") {
                // Trigger login intent in ViewModel
            }
            .disabled(!viewModel.canSubmit)
        }
        .navigationTitle("Login")
    }
}
```

### Demo 3: Debounced Search
```swift
import SwiftUI
import Combine

struct MockSearchService {
    private let values = [
        "Apple", "Apricot", "Banana", "Blueberry", "Cherry",
        "Grape", "Kiwi", "Mango", "Orange", "Peach"
    ]

    func search(query: String) -> AnyPublisher<[String], Never> {
        guard !query.isEmpty else {
            return Just([]).eraseToAnyPublisher()
        }

        let filtered = values.filter { $0.localizedCaseInsensitiveContains(query) }

        return Just(filtered)
            .delay(for: .milliseconds(250), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

final class DebouncedSearchViewModel: ObservableObject {
    @Published var query: String = ""
    @Published private(set) var results: [String] = []
    @Published private(set) var isSearching: Bool = false

    private let service: MockSearchService
    private var cancellables = Set<AnyCancellable>()

    init(service: MockSearchService = MockSearchService()) {
        self.service = service

        $query
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] text in
                self?.isSearching = !text.isEmpty
            })
            .flatMap { [service] text in
                service.search(query: text)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.results = result
                self?.isSearching = false
            }
            .store(in: &cancellables)
    }
}

struct DebouncedSearchView: View {
    @StateObject private var viewModel = DebouncedSearchViewModel()

    var body: some View {
        VStack {
            TextField("Search...", text: $viewModel.query)
                .textFieldStyle(.roundedBorder)
                .padding()

            if viewModel.isSearching {
                ProgressView("Searching...")
            }

            List(viewModel.results, id: \.self) { item in
                Text(item)
            }
        }
        .navigationTitle("Debounced Search")
    }
}
```

### Demo 4: URLSession + Combine
```swift
import SwiftUI
import Combine

struct Post: Decodable, Identifiable {
    let id: Int
    let title: String
}

final class PostsViewModel: ObservableObject {
    @Published private(set) var posts: [Post] = []
    @Published private(set) var isLoading = false
    @Published private(set) var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    func loadPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts?_limit=10") else {
            return
        }

        isLoading = true
        errorMessage = nil

        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Post].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoading = false
                    if case let .failure(error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                },
                receiveValue: { [weak self] posts in
                    self?.posts = posts
                }
            )
            .store(in: &cancellables)
    }
}

struct PostsView: View {
    @StateObject private var viewModel = PostsViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading posts...")
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 12) {
                        Text("Failed to load posts")
                            .font(.headline)
                        Text(error)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            viewModel.loadPosts()
                        }
                    }
                    .padding()
                } else {
                    List(viewModel.posts) { post in
                        Text(post.title)
                    }
                }
            }
            .navigationTitle("Posts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Reload") {
                        viewModel.loadPosts()
                    }
                }
            }
            .onAppear {
                viewModel.loadPosts()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
```
