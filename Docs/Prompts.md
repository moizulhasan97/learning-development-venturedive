# AI Prompt Log — Xcode 26 Coding Intelligence

Project: **Ghibli Movie Browser**  
Tech: SwiftUI · Combine · async/await · Clean Architecture · Theme Manager  
API: Studio Ghibli (Vercel)

---

## Prompt 1 — Generate Full App (List + Detail + Cast + Themes)

**Goal**  
Generate a production-ready SwiftUI app demonstrating:
- SwiftUI UI (list, search, detail)
- Combine (debounced search)
- Structured concurrency (async/await)
- Clean separation of concerns (Presentation / Domain / Data)
- Protocol-based theming
- Multiple API calls (films, film detail, cast)

**Result**  
- App scaffolded with strict Clean Architecture boundaries  
- Movie list with debounced client-side search  
- Movie detail screen with independent film + cast loading  
- Runtime theme switching implemented

**Evidence**  
- Recording: `prompt-01-ai-generated-results.mov`  
- Recording: `prompt-01-creating-files-folders-crct.mov`  
- Screenshot: `prompt-01-complete-folders-files.png`

---

## Prompt 2 — Fix Compilation Errors

**Goal**  
Resolve compilation issues without changing architecture or intent.

**Result**  
- All compilation errors fixed  
- Architecture preserved (no layer leakage)  
- App builds and runs successfully

**Evidence**  
- Recording: `prompt-01-fix-compilation-errors.mov`  
- Screenshot: `prompt-01-compilation-errors.png`

---

## Prompt 3 — Add Typed APIError & Robust Error Handling

**Goal**  
Introduce a strongly-typed `APIError` and improve error propagation.

**Result**  
- Typed `APIError` added and mapped from network/decoding failures  
- ViewModels surface user-friendly error messages  
- No networking details leaked into Presentation or Domain layers

**Evidence**  
- Recording: `prompt-01-add-api-error-handler.mov`  
- Screenshot: `prompt-01-api-error.png`

---

## Prompt 4 — Apply Suggested Changes

**Goal**  
Apply proposed fixes and improvements as patch updates.

**Result**  
- All suggested changes applied cleanly  
- Project continues to compile and run

**Evidence**  
- Recording: `prompt-01-apply-suggested-changes.mov`

---

## Prompt 5 — Add Unit Tests (Clean Architecture, Deterministic)

**Goal**  
Add deterministic unit tests across Domain and Presentation layers while:
- Preserving async/await use cases
- Avoiding real networking
- Preventing architectural drift

**Result**  
- Unit tests added for:
  - Domain use cases (GetFilms, GetFilmDetail, GetPeople)
  - MovieListViewModel state transitions and filtering logic
  - MovieDetailViewModel film + cast loading flows
- Combine debounce made testable via minimal scheduler injection
- Tests are deterministic and non-flaky

**Evidence**  
- Recording: `testing-prompt-00.mov`  
- Screenshots: `testing-initial-00.png`, `testing-files-folders.png`

---

## Prompt 6 — Movie List Banner Image (`movie_banner`) + Test Updates

**Goal**  
Display each film’s `movie_banner` image in the movie list while maintaining Clean Architecture and updating tests accordingly.

**Result**  
- `movie_banner` decoded in `FilmDTO` and mapped to `Film.movieBannerURL`
- Movie list rows show leading banner thumbnails via `AsyncImage`
- Safe fallback implemented for nil/invalid/broken URLs
- DTO → Domain mapping tests updated
- Existing Film fixtures updated to compile

**Evidence**  
- Recording: `listing-view-image-prompt.mov`

---

## Prompt 7 — Visual Enhancements (Stretchy Header + Skeletons)

**Goal**  
Improve visual quality using SwiftUI-native techniques without altering architecture or business logic.

**Result**  
- Skeleton loaders replace spinners for list and detail screens
- Movie detail screen features a stretchy hero header using `movie_banner`
- Animated score visualization added for `rtScore`
- Smooth transitions between loading and loaded states
- All visuals respect existing Theme tokens

**Evidence**  
- Recording: `visual-improvement.mov`

---

## Human Intervention & Engineering Decisions

The following steps were handled manually to ensure production quality:

- Enforced Clean Architecture boundaries across all changes
- Refactored ViewModels for correct structured concurrency usage
- Introduced scheduler injection for testable Combine pipelines
- Fixed AI-generated naming inconsistencies and model mismatches
- Validated behavior through unit tests instead of visual assumptions

---

## Prompt Engineering Summary

This project demonstrates controlled AI-assisted development by:
- Starting with a high-level architectural prompt
- Iteratively refining behavior through constrained follow-up prompts
- Using AI for generation, debugging, refactoring, and enhancement
- Enforcing architectural and concurrency rules explicitly
- Validating output through deterministic unit tests

The result is a production-quality, testable SwiftUI application built through deliberate prompt engineering rather than uncontrolled code generation.
