# SwiftUI: Writing It Right (As a Team)

Ownership • Modifiers • Refactoring • Structure

## Learning Game Mode
- Level 1: SwiftUI: Writing It Right
- Level 2: SwiftUI + Combine (unlocks after Level 1 in app hub)
- Upcoming Future: Level 3+ placeholders for upcoming workshops

## Slide 1 — Title
### On Slide
- SwiftUI: Writing It Right (As a Team)
- Ownership • Modifiers • Refactoring • Structure

### What to Say
- Everyone here can write SwiftUI.
- Today is about writing SwiftUI that other developers understand instantly.

---

## Slide 2 — Why This Meeting Exists
### On Slide
#### Current Reality
- Same UI, different code styles
- State everywhere
- Hard PR reviews
- Fragile changes

#### Goal
- One mental model
- One structure
- One way to think

### What to Say
- We are not learning SwiftUI.
- We are learning how not to hurt ourselves later.

---

## Slide 3 — The One SwiftUI Rule (Like You’re 10)
### On Slide
- UI = Mirror of Data
- Data changes → UI updates
- UI does not control data
- Views describe, they don’t decide

### What to Say
- SwiftUI is a mirror.
- You don’t move the mirror — you move yourself.

---

## Slide 4 — Property Wrappers = Ownership
### On Slide
#### Only One Question
- Who owns this data?

#### Toy Analogy
- My toy → `@State`
- Borrowed toy → `@Binding`
- Shared toy → `@EnvironmentObject`
- Room rules → `@Environment`

### What to Say
- Every SwiftUI bug starts with unclear ownership.

---

## Slide 5 — Property Wrapper Cheat Sheet
### On Slide
| Wrapper | Meaning (Simple) |
| --- | --- |
| `@State` | This view owns it |
| `@Binding` | Parent owns it |
| `@StateObject` | I own the class |
| `@ObservedObject` | Someone else owns it |
| `@EnvironmentObject` | App owns it |
| `@Environment` | System info |

### What to Say
- If two wrappers could work — one of them is wrong.

---

## Slide 6 — BAD → GOOD: Refactoring State Ownership
### On Slide
#### ❌ Bad (Unstable State)
```swift
struct ProfileView: View {
    @ObservedObject var vm = ProfileViewModel()
}
```

#### Why bad
- Recreated on redraw
- State resets
- Hidden bugs

#### ✅ Good (Clear Ownership)
```swift
struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
}
```

### What to Say
- If the view creates it, the view must keep it alive.

---

## Slide 7 — BAD → GOOD: Refactoring `@Binding` Misuse
### On Slide
#### ❌ Bad (Child Decides Logic)
```swift
struct ChildView: View {
    @Binding var isOn: Bool

    func toggle() {
        isOn.toggle()
        saveToServer()
    }
}
```

#### ✅ Good (Parent Decides)
```swift
struct ChildView: View {
    let isOn: Bool
    let onToggle: () -> Void
}

ChildView(isOn: isOn) {
    isOn.toggle()
    saveToServer()
}
```

### What to Say
- Child reports what happened.
- Parent decides what it means.

---

## Slide 8 — Code Structure (MANDATORY STANDARD)
### On Slide
```swift
struct ExampleView: View {

    // MARK: - Inputs
    let title: String

    // MARK: - State
    @State private var isActive = false

    // MARK: - Body
    var body: some View {
        content
    }

    // MARK: - Subviews
    private var content: some View {
        Text(title)
    }
}
```

### What to Say
- If every file looks the same, your brain relaxes.

---

## Slide 9 — Modifiers = Lego Blocks
### On Slide
#### Key Idea
- Each modifier wraps the view
- Order changes behavior

```swift
Text("Hello")
    .padding()
    .background(Color.red)
```

is not equal to

```swift
Text("Hello")
    .background(Color.red)
    .padding()
```

#### Rule
- Layout → Color → Interaction

### What to Say
- Wrong order = wrong UI.

---

## Slide 10 — BAD → GOOD: Reusable Modifiers
### On Slide
#### ❌ Bad (Copy-Paste Styling)
```swift
.font(.headline)
.padding()
.background(Color.blue)
.cornerRadius(8)
```

#### ✅ Good (Intent-Based Modifier)
```swift
Text("Login")
    .primaryButton()

extension View {
    func primaryButton() -> some View {
        self
            .font(.headline)
            .padding()
            .background(Color.blue)
            .cornerRadius(8)
    }
}
```

### What to Say
- If style appears twice, extract it once.

---

## Slide 11 — `@ViewBuilder`: Cleaning Messy Views
### On Slide
#### Problem
- Conditionals make `body` ugly.

#### Solution
- Group intent.

```swift
@ViewBuilder
var statusView: some View {
    if loading {
        ProgressView()
    } else {
        Text("Done")
    }
}
```

### What to Say
- ViewBuilder is for structure, not cleverness.

---

## Slide 12 — Good Practices (Final Rules)
### On Slide
- Ownership decides property wrapper
- `@State` is local and private
- `@Binding` = permission, not logic
- Views describe, parents decide
- Extract repeated styles into modifiers
- Layout → Color → Interaction
- Avoid `AnyView`
- State lives as low as possible

### What to Say
- Boring SwiftUI is good SwiftUI.
- Predictable code scales.

---

## Demo Map (In This Project)
- Slide 3 + foundations: `SwiftUIBasicsDemoView`
- Slide 6: `StateOwnershipDemoView`
- Slide 7: `BindingOwnershipDemoView`
- Slide 9: `ModifierOrderDemoView`
- Slide 10: `ReusableModifierDemoView`
- Slide 11: `ViewBuilderDemoView`
- Slide 8 + 12: `ViewStructureStandardDemoView`
- Team standards deep dive: `SwiftUITeamStandardsDemoView`

---

## Extended Slide 13 — SwiftUI Architecture Basics
### On Slide
- View = rendering and user intent capture
- ViewModel = state + business logic
- Service = side effects (network, db, analytics)

### What to Say
- Keep Views lightweight and deterministic.
- Put side effects behind methods in ViewModel/Service.

### Code Example
```swift
struct ProfileView: View {
    @StateObject private var vm = ProfileViewModel()
}
```

---

## Extended Slide 14 — State Placement Rule
### On Slide
- State lives as low as possible
- Shared state only when two siblings need it
- Avoid global state by default

### What to Say
- Local first, shared second, global last.

---

## Extended Slide 15 — Naming and File Standards
### On Slide
- One concept per view file
- Suffixes: `View`, `ViewModel`, `Service`
- Clear foldering: `Features/`, `Shared/`

### What to Say
- Folder clarity reduces onboarding time and merge conflicts.

---

## Extended Slide 16 — Accessibility Minimums
### On Slide
- Buttons have clear labels
- Dynamic Type respected
- Color is not the only status signal

### What to Say
- Accessibility is a quality baseline, not a polish step.

---

## Extended Slide 17 — Performance Basics
### On Slide
- Keep `body` simple
- Extract expensive work out of computed view trees
- Prefer value types for lightweight state

### What to Say
- Recomposition is normal; heavy logic inside `body` is not.

---

## Extended Slide 18 — Team PR Checklist
### On Slide
- Ownership wrapper correct?
- Child free from business logic?
- Modifier order intentional?
- Reused style extracted?
- Tests/preview added for behavior?

### What to Say
- Same checklist on every PR creates stable code quality.
