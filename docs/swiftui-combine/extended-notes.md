# SwiftUI + Combine Extended Notes

## Practical Team Standards
- Keep pipelines in ViewModel, not View.
- Keep each pipeline focused on one responsibility.
- Name intermediate publishers if the chain grows.
- Use `receive(on: DispatchQueue.main)` before UI state mutations.
- Store subscriptions in `Set<AnyCancellable>`.

## When Combine Is the Right Tool
- Multiple changing inputs must produce one derived output.
- UI needs continuous updates from user typing, timers, notifications, or websocket-like streams.
- You need stream composition (`merge`, `combineLatest`, `zip`, `flatMap`).

## When async/await Is Better
- One request in, one response out.
- Straight sequential flow with simple error handling.
- Minimal transformation requirements.

## Review Checklist for Combine Code
- Is cancellation handled?
- Are state mutations on main thread?
- Are retain cycles prevented?
- Is error state observable and user-facing?
- Is the chain readable and testable?

## Suggested Learning Path
1. Counter stream + `scan`
2. Form validation + `combineLatest`
3. Debounced search + `debounce` + `flatMap`
4. URLSession + decoding + state flow
5. Production conventions and tradeoffs
