# SwiftUI + Combine (iOS 15+) — Speaker Cheat Sheet

Use this as your live speaking script. Keep pace, keep it simple.

## Session Timing (60 min)
- 00:00-03:00: Intro and expectations
- 03:00-18:00: Core concepts
- 18:00-33:00: SwiftUI + Combine architecture
- 33:00-43:00: Live coding demos
- 43:00-50:00: Use cases + pros/cons/limitations
- 50:00-54:00: Good practices vs rookie mistakes
- 54:00-58:00: Interview Q&A
- 58:00-60:00: Wrap-up

---

## Opening Script (Read Exactly)
- "Welcome everyone. Today we learn SwiftUI + Combine from zero."
- "This session is practical. I will avoid complicated language."
- "If you know basic SwiftUI, you can fully follow this."

---

## Key Beginner Definitions (Repeat Often)
- "Publisher sends values over time."
- "Subscriber receives those values."
- "Operator changes or filters those values."
- "AnyCancellable keeps the connection alive."
- "@Published tells SwiftUI that state changed."

---

## Easy Analogies
- "Think of Publisher as a speaker with a microphone."
- "Subscriber is the audience listening."
- "Operator is an editor in between."
- "AnyCancellable is your active event pass."

---

## Transitions You Can Reuse
- "Now that we know words, let’s see app architecture."
- "Now we move from concept to real code."
- "Now let’s apply this in production-like examples."

---

## Architecture Lines (MVVM)
- "View should render and forward user actions only."
- "ViewModel should own state and business logic."
- "Combine pipelines should mostly live in ViewModel."
- "This keeps code testable and clean."

---

## Demo Intro Lines
### Demo 1: Counter
- "This is the smallest event-stream example."
- "Two taps become two streams."

### Demo 2: Form Validation
- "This removes manual validation checks."
- "Button state updates automatically while typing."

### Demo 3: Debounced Search
- "This prevents API calls on every keystroke."
- "Debounce waits for user pause."

### Demo 4: URLSession + Combine
- "This is a production-style loading-success-error flow."
- "Always move UI state updates to main thread."

---

## If Audience Looks Confused
Use this reset line:
- "Forget framework names for a second."
- "Data changes -> pipeline runs -> UI updates."
- "That is Combine in beginner form."

---

## Memory and Threading Safety Lines
- "Store cancellables, or stream can stop early."
- "Use [weak self] in sink closures to avoid retain cycles."
- "Use receive(on:) before UI updates."

---

## Rookie Mistakes to Call Out
- "Putting business logic inside SwiftUI Views."
- "Creating giant unreadable pipelines."
- "Using Subjects everywhere instead of @Published."
- "Forgetting cancellation and lifecycle management."

---

## Combine vs async/await (Simple Rule)
- "One request, one response -> async/await is usually simpler."
- "Continuous changing values -> Combine is usually better."

---

## Interview Quick Answers
- Q: "What is a Publisher?"
- A: "A source that emits values over time."

- Q: "Why AnyCancellable?"
- A: "To keep or cancel a subscription safely."

- Q: "PassthroughSubject vs CurrentValueSubject?"
- A: "Passthrough sends new events only. CurrentValue also stores latest value."

- Q: "Why receive(on: DispatchQueue.main)?"
- A: "UI must update on the main thread."

- Q: "When would you avoid Combine?"
- A: "For very simple one-shot async tasks where async/await is cleaner."

---

## Closing Script (Read Exactly)
- "Do not try to master all operators at once."
- "Start with three patterns: validation, debounced search, and loading/error state."
- "Once these are comfortable, advanced Combine becomes much easier."

---

## Optional Q&A Prompt
- "If you want, next session can focus on testing Combine ViewModels with XCTest and mock publishers."
