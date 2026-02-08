# SwiftUI + Combine (iOS 15+) — 45-Minute Rehearsal Version

Use this for fast practice runs.
- Only stage lines
- Only demo checkpoints
- No deep theory

## Rehearsal Timing (45 min)
- 00:00-02:00: Opening and audience alignment
- 02:00-08:00: Combine basics in plain language
- 08:00-15:00: Core terms with one-liner meanings
- 15:00-23:00: SwiftUI + MVVM integration flow
- 23:00-35:00: 4 live demo checkpoints
- 35:00-40:00: Good practices and rookie mistakes
- 40:00-43:00: Interview quick-fire
- 43:00-45:00: Closing recap

---

## 1) Opening Script (00:00-02:00)
Say exactly:
- "Welcome everyone. Today we learn SwiftUI + Combine from zero."
- "This session is practical. I will keep language simple and direct."
- "If you know basic SwiftUI views, you can fully follow this."
- "Goal: after this session, you can build real Combine-based screens."

Checkpoint:
- Audience understands this is beginner-friendly and practical.

---

## 2) Combine Basics in Plain Language (02:00-08:00)
Say exactly:
- "Combine is a tool to react to changing data."
- "When data changes, UI can update automatically."
- "Examples: user typing, timer updates, API responses."
- "Without Combine, async code can become repetitive and messy."

Simple compare line:
- "One request and done? async/await is often simpler."
- "Continuous updates over time? Combine is often better."

Checkpoint:
- Audience can repeat: "Combine = react to changing values over time."

---

## 3) Core Terms One-Liners (08:00-15:00)
Say exactly:
- "Publisher sends values over time."
- "Subscriber receives values."
- "Operator transforms values."
- "Subscription starts when we call sink or assign."
- "AnyCancellable keeps subscription alive."
- "@Published announces property changes from ViewModel."
- "PassthroughSubject sends events only."
- "CurrentValueSubject sends events and stores latest value."

Memory safety line:
- "If you don’t store cancellables, your stream may stop unexpectedly."

Checkpoint:
- Ask: "Which subject stores latest value?" Expected answer: CurrentValueSubject.

---

## 4) SwiftUI + MVVM Flow (15:00-23:00)
Say exactly:
- "View should render UI and forward user actions only."
- "ViewModel should own state and business logic."
- "Combine pipelines should mostly live in ViewModel."
- "State changes in @Published should drive UI updates."

Real-screen flow line:
- "User taps load -> isLoading true -> API pipeline -> success or error -> isLoading false."

Threading line:
- "UI state updates should happen on main thread using receive(on:)."

Checkpoint:
- Audience can explain loading-success-error flow in one sentence.

---

## 5) Live Demo Checkpoints (23:00-35:00)

### Demo 1: Counter (23:00-26:00)
Say exactly:
- "This is the smallest event-stream example."
- "Two button taps become two streams."
- "We merge them and use scan for running total."

Checkpoint:
- +1 and -1 update count correctly.

### Demo 2: Form Validation (26:00-29:00)
Say exactly:
- "Email and password are @Published."
- "combineLatest computes whether submit is allowed."
- "Button state updates automatically while typing."

Checkpoint:
- Invalid input disables button; valid input enables button.

### Demo 3: Debounced Search (29:00-32:00)
Say exactly:
- "debounce waits for user pause."
- "removeDuplicates avoids repeated work."
- "This prevents request spam and improves UX."

Checkpoint:
- Results update after pause, not every keystroke.

### Demo 4: URLSession + Combine (32:00-35:00)
Say exactly:
- "dataTaskPublisher + decode gives us a clean network pipeline."
- "ViewModel updates loading, data, and error state."
- "This pattern is production-ready for list screens."

Checkpoint:
- Load works, error state shown on failure, retry works.

---

## 6) Good Practices vs Rookie Mistakes (35:00-40:00)
Say exactly:
- "Store AnyCancellable in ViewModel lifecycle."
- "Use weak self in sink closures."
- "Keep business logic out of SwiftUI Views."
- "Keep pipelines small and readable."

Rookie mistakes to call out:
- "Retain cycles from strong self capture."
- "Overusing Subject when @Published is enough."
- "Long, hard-to-debug pipeline chains."

Checkpoint:
- Audience can list one memory mistake and one architecture mistake.

---

## 7) Interview Quick-Fire (40:00-43:00)
Say exactly:
- "Publisher emits values over time."
- "AnyCancellable controls subscription lifetime."
- "PassthroughSubject: event only. CurrentValueSubject: event + latest value."
- "Use receive(on: .main) before UI updates."
- "Combine for streams; async/await for simple one-shot tasks."

Checkpoint:
- Audience can answer "Combine vs async/await" with confidence.

---

## 8) Closing Script (43:00-45:00)
Say exactly:
- "Do not try to learn every operator at once."
- "Start with three patterns: validation, debounced search, loading/error pipelines."
- "Once these are comfortable, advanced Combine becomes much easier."

Final line:
- "If you want, next session can be testing Combine ViewModels with XCTest."

---

## Emergency Time-Cut Plan (If running late)
- Skip deep explanation of subject types: save 2 minutes
- Merge Demo 1 and Demo 2 discussion: save 2 minutes
- Cut interview section to 3 questions: save 2 minutes

