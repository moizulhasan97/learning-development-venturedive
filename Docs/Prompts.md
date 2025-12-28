# AI Prompt Log — Xcode 26 Coding Intelligence

Project: **Ghibli Movie Browser**
Tech: SwiftUI + Combine + async/await + Clean layering + Theme Manager  
API: Studio Ghibli (Vercel)

---

## Prompt 1 — Generate full app (list + detail + cast + themes)

**Goal**
Generate a production-ready SwiftUI app demonstrating:
- SwiftUI UI (list + search + detail)
- Combine (debounced search)
- Structured concurrency (async/await networking)
- Clean separation of concerns (Presentation / Domain / Data)
- Multi-theme support (protocol-based theme manager)
- Multiple API calls (films list + film detail + people/cast)

**Prompt**
Generate a production-ready app called “Ghibli Movie Browser” demonstrating SwiftUI + Combine + structured concurrency (async/await) and clean separation of concerns.

Public API (no auth)

Use the Studio Ghibli API (Vercel):
1. Films list: GET https://ghibliapi.vercel.app/films
2. Film detail: GET https://ghibliapi.vercel.app/films/{id}
3. People list: GET https://ghibliapi.vercel.app/people

Features (must demonstrate)
Screen 1: Movie List + Debounced Search
- On launch, fetch films using async/await.
- Implement search using Combine debounce (400ms) on a @Published query in the ViewModel.
- Client-side filtering (case-insensitive, trims whitespace).
- UI states: Loading, Empty (no query), Empty (no results), Error with Retry
- Selecting a movie navigates to detail screen.

Screen 2: Movie Detail + Additional API calls
- Fetch film detail by id (/films/{id})
- Also fetch “Cast” by calling /people and filter by film URL
- Cast section has independent loading/empty/error states.

Theme system (protocol-based) + runtime switching
- Theme protocol (tokens)
- 3 themes (Light/Dark/Cinema)
- ThemeManaging protocol + ThemeManager (ObservableObject) with UserDefaults persistence
- Expose theme via Environment
- UI entry point for runtime switching with animation
- No hardcoded colors

Architecture constraints (very important)
- Presentation / Domain / Data layering
- Presentation depends on Domain only
- Domain has no dependency on Data or SwiftUI
- Data has API clients + DTOs + mapping

Concurrency & Combine rules
- async/await URLSession networking
- @MainActor ViewModels
- Combine debounce in ViewModel

Output instructions
- Provide folder structure + file-by-file code, update ContentView/app entry

**Result**
- App created with clean layers, list screen with debounced search, detail screen
- Multiple API calls implemented (films + detail + people/cast)
- Theme manager added with runtime switching

**Evidence**
- Recording: prompt-01-ai-generated-results.mov, prompt-01-creating-files-folders-crct.mov
- Screenshot(s): prompt-01-complete-folders-files.png

---

## Prompt 2 — Fix compilation errors

**Goal**
Make the generated project compile without breaking the architecture.

**Prompt**
The code you just generated does not compile.
Please analyze the current compilation errors shown in Xcode and fix them while keeping the existing architecture intact.

Requirements:
- Do NOT change the overall architecture (Presentation / Domain / Data / Theme)
- Fix missing imports, incorrect generic constraints, protocol conformance issues, and async/await or Combine mistakes
- Ensure all ViewModels are correctly annotated with @MainActor where UI state is mutated
- Ensure all generic types conform to required protocols (e.g., Equatable, Sendable)
- Ensure all files compile cleanly

Provide the exact code changes needed file-by-file.

**Result**
- Compilation issues resolved while keeping layer boundaries intact
- App builds successfully and runs

**Evidence**
- Recording: prompt-01-fix-compilation-errors.mov
- Screenshot(s): prompt-01-compilation-errors.png

---

## Prompt 3 — Add APIError + robust error handling

**Goal**
Upgrade networking to typed errors and user-friendly error surfacing.

**Prompt**
Improve the networking layer by introducing a strongly typed APIError and proper error handling.

Requirements:
- Add an APIError enum covering at least:
  - invalidURL
  - network(Error)
  - invalidResponse
  - httpError(statusCode: Int)
  - decoding(Error)
- Ensure APIError conforms to LocalizedError and provides user-friendly error messages.
- Update the API client(s) to throw APIError instead of generic Error.
- Map low-level errors (URLSession, decoding, HTTP status) to APIError.
- Ensure repository implementations propagate APIError without leaking networking details to Domain.
- Update ViewModels to surface meaningful error messages via existing load/error states.
- Do NOT change architecture boundaries (Presentation / Domain / Data).

Provide file-by-file code changes only where needed.

**Result**
- APIError introduced and used across network/data layers
- Better error mapping and UI-facing error messaging

**Evidence**
- Recording: prompt-01-add-api-error-handler.mov
- Screenshot(s): prompt-01-api-error.png

---

## Prompt 4 — Apply suggested changes

**Goal**
Apply the proposed changes into existing files as patch updates.

**Prompt**
Please update the changes that you have mentioned in the existing files.

**Result**
- Changes applied and project continued to compile/run as expected

**Evidence**
- Recording: prompt-01-apply-suggested-changes.mov

---

## Human Intervention & Engineering Decisions

While Xcode AI generated the initial structure and code, several decisions and refinements were made manually:

- Verified and enforced Clean Architecture boundaries between Presentation, Domain, and Data layers
- Refactored ViewModels to use structured concurrency correctly (async APIs instead of fire-and-forget tasks)
- Improved testability by injecting scheduler and debounce parameters into Combine pipelines
- Wrote and adjusted unit tests to ensure deterministic behavior for async/Combine code
- Reviewed AI-generated code for naming consistency, API correctness, and model alignment

This ensured the final implementation was production-quality, testable, and aligned with best practices.

---

## Prompt Engineering Summary

This project demonstrates effective prompt engineering by:
- Starting with a high-level architectural prompt
- Iteratively refining the output through focused follow-up prompts
- Using AI for generation, debugging, refactoring, and enhancement
- Guiding the AI with constraints (architecture, concurrency rules, layering)
- Validating and correcting AI output through testing and manual review

The result is a working, testable application created through deliberate and controlled AI-assisted development rather than passive code generation.
