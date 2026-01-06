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

## Prompt 5 - Add Unit Tests (Clean Architecture, Deterministic)

**Goal**
- Add comprehensive, deterministic unit tests for the app while preserving Clean Architecture, existing async/await use cases, and domain models. Demonstrate controlled prompt engineering to guide AI-assisted test generation without introducing new models, networking, or architectural drift.

**Prompt**
- I added a Unit Test target named learning-development-venturediveTests.
I will create folders and files manually in Xcode, so DO NOT create files or folders automatically.

Hard constraints (must follow)
    1.    Use my existing types exactly — do not invent new models or rename anything:

    •    Domain models: Film, Person
    •    Domain protocols: FilmRepository, PeopleRepository, GetFilmsUseCase, GetFilmDetailUseCase, GetPeopleUseCase
    •    Domain implementations: DefaultGetFilmsUseCase, DefaultGetFilmDetailUseCase, DefaultGetPeopleUseCase
    •    Presentation: LoadState<T>, MovieListViewModel (with State), MovieDetailViewModel
    •    Data: RemoteFilmRepository, RemotePeopleRepository, FilmDTO, PersonDTO, GhibliAPIClient, APIError

    2.    Do NOT introduce any Movie model, GetMoviesUseCase, or AnyPublisher-based use cases. My use cases are async throws.
    3.    Tests must be deterministic: no real networking, no sleep(), no time-based flakiness.
    4.    Keep architecture intact (Presentation/Domain/Data).

Output format
    1.    First output a Test File Manifest listing the exact test files I should create, for example:

    •    learning-development-venturediveTests/TestDoubles/FilmRepositorySpy.swift
    •    learning-development-venturediveTests/TestDoubles/PeopleRepositorySpy.swift
    •    learning-development-venturediveTests/TestDoubles/GetFilmsUseCaseStub.swift
    •    learning-development-venturediveTests/Domain/DefaultGetFilmsUseCaseTests.swift
    •    learning-development-venturediveTests/Domain/DefaultGetFilmDetailUseCaseTests.swift
    •    learning-development-venturediveTests/Domain/DefaultGetPeopleUseCaseTests.swift
    •    learning-development-venturediveTests/Presentation/MovieListViewModelTests.swift
    •    learning-development-venturediveTests/Presentation/MovieDetailViewModelTests.swift
    •    (Optional) learning-development-venturediveTests/Data/DTOToDomainMappingTests.swift

    2.    Then output paste-ready code file-by-file with headers exactly like:
// FILE: learning-development-venturediveTests/Presentation/MovieListViewModelTests.swift
<full code>

App module import

In each test file use:
@testable import learning_development_venturedive

Test scope

A) Domain Unit Tests (async/await, no networking)

Write XCTest cases for:
    1.    DefaultGetFilmsUseCase
    •    Success: returns films from a FilmRepository spy/stub
    •    Failure: propagates thrown error
    •    Verify the repository method fetchFilms() was called exactly once
    2.    DefaultGetFilmDetailUseCase
    •    Success: returns film from fetchFilmDetail(id:)
    •    Failure: propagates thrown error
    •    Verify correct id was passed
    3.    DefaultGetPeopleUseCase
    •    Success: returns people from PeopleRepository
    •    Failure: propagates thrown error
    •    Verify repository method called once

Use lightweight test doubles (spies/stubs) for FilmRepository and PeopleRepository.

B) Presentation Unit Tests

MovieListViewModel

My current code:
    •    load() sets state = .loading, then on success sets items, state = .loaded, and calls applyFilter()
    •    applyFilter() trims whitespace and filters by title, originalTitle, director (case-insensitive)
    •    Search is bound using Combine:
$query.debounce(for: .milliseconds(400), scheduler: DispatchQueue.main).removeDuplicates().sink { applyFilter() }

Write tests for:
    1.    load() success:
    •    state transitions .idle → .loading → .loaded
    •    items and filtered contain expected films
    2.    load() failure:
    •    state transitions .idle → .loading → .error(String)
    3.    filtering correctness:
    •    empty query => filtered == items
    •    trimming works ("  miyazaki  ")
    •    case-insensitive match
    •    matches title/originalTitle/director as implemented

Combine debounce testability (required)

Debounce with DispatchQueue.main will be flaky. Propose the smallest production refactor that keeps runtime behavior the same but allows deterministic tests by injecting:
    •    a scheduler (preferred), or
    •    a debounce duration/time provider

Output the minimal production code edits (file-by-file) to MovieListViewModel only (do not alter architecture).
Then write tests that trigger filtering deterministically without real delays.

MovieDetailViewModel

My current code:
    •    filmState: LoadState<Film> and castState: LoadState<[Person]>
    •    load(id:) starts two Tasks:
    •    loadFilm(id:) → .loading then .loaded(film) or .failed(message)
    •    loadCast(for:) → calls getPeople.execute(), then filters people whose person.films contains URL "https://ghibliapi.vercel.app/films/<id>"

Write tests for:
    1.    film success: .idle → .loading → .loaded(film)
    2.    film failure: .idle → .loading → .failed(message)
    3.    cast success:
    •    returns only matching people for the given film id URL
    •    .idle → .loading → .loaded(filteredCast)
    4.    cast failure: .idle → .loading → .failed(message)

Use test doubles for GetFilmDetailUseCase and GetPeopleUseCase that return deterministic async results.
Use XCTestExpectation or await patterns so tests don’t rely on time delays.

C) Optional Data Tests (only if easy)

Add mapping tests:
    •    FilmDTO.toDomain() maps fields correctly and parses url
    •    PersonDTO.toDomain() maps films strings to [URL]
Do NOT call real GhibliAPIClient or network.

Final checklist section

After all files, include:
    •    How to create the test folders/files in Xcode and ensure they’re in the test target
    •    How to run tests (⌘U)
    •    A short list of what each test file verifies

**Result**
- Unit tests were added across Domain, Presentation, and Data mapping layers using async/await and test doubles. Combine-based search logic was made testable via minimal dependency injection, enabling reliable, non-flaky tests. The final test suite validates use cases, view-model state transitions, filtering logic, and DTO-to-domain mappings while keeping production behavior unchanged.

**Evidence**
- Recording: testing-prompt-00.mov
- Screenshot(s): testing-initial-00.png, testing-files-folders.png

--

## Prompt 6 — List row banner image (movie_banner) + test updates

**Goal**
Enhance the Movie List UI by showing each film’s `movie_banner` image as a leading thumbnail, while preserving Clean Architecture boundaries and adding deterministic unit test coverage for the new mapping.

**Prompt**
Update the existing “Ghibli Movie Browser” app to display each film’s ⁠ movie_banner ⁠ image on the leading side of each row in the Movie List.

Hard constraints:
•⁠  ⁠Keep the existing architecture intact (Presentation / Domain / Data)
•⁠  ⁠Do NOT introduce new models or rename existing ones
•⁠  ⁠Do NOT hardcode API URLs in the Presentation layer
•⁠  ⁠Do NOT add third-party dependencies
•⁠  ⁠Use async/await for image loading (SwiftUI AsyncImage is fine)

Important:
The ⁠ movie_banner ⁠ field is NOT currently handled anywhere in the project.

You MUST:
•⁠  ⁠Add ⁠ movie_banner ⁠ decoding to FilmDTO
•⁠  ⁠Map it in FilmDTO.toDomain()
•⁠  ⁠Add a corresponding optional property to the existing Film domain model (e.g. ⁠ movieBannerURL: URL? ⁠)
•⁠  ⁠Propagate this value through repositories/use cases without breaking existing code

Do NOT:
•⁠  ⁠Create a new Film model
•⁠  ⁠Rename Film or introduce a Movie model
•⁠  ⁠Bypass the Domain layer by using DTOs in Presentation

Requirements:

1) Data layer: decode + map movie_banner
•⁠  ⁠Update FilmDTO to decode the ⁠ movie_banner ⁠ field from the API response.
•⁠  ⁠Update FilmDTO.toDomain() to map ⁠ movie_banner ⁠ into the Film domain model.
•⁠  ⁠Ensure JSON decoding still works for existing fields.

2) Domain layer: add property to Film
•⁠  ⁠Update the existing Film struct to include an optional banner URL property for movie_banner.
•⁠  ⁠Keep naming consistent across layers (FilmDTO → Film).
•⁠  ⁠Ensure the change does not break existing initializers/usages (update init call sites as needed).

3) Presentation layer: show image in list row with fallback
•⁠  ⁠In MovieListView’s FilmRow, add a leading thumbnail image sourced from ⁠ film.movieBannerURL ⁠.
•⁠  ⁠Use a clean row layout: thumbnail leading, text content trailing.
•⁠  ⁠If the banner URL is nil OR not a valid http/https URL OR the image fails to load, show a suitable built-in iOS placeholder image (SF Symbol like ⁠ film ⁠ or ⁠ photo ⁠) styled using the existing Theme tokens (no hardcoded colors).

4) “Broken URL” handling via extension (required)
•⁠  ⁠Add a URL validation helper using an extension (in Core or Presentation), for example:
  - ⁠ URL.isHTTPURL ⁠ (true only for http/https)
•⁠  ⁠Use this extension before attempting to load the remote image.
•⁠  ⁠For actual load failures (AsyncImage error phase), fall back to the placeholder UI.

5) Update Unit Tests accordingly (required)
•⁠  ⁠Update any existing tests that construct Film instances to include the new ⁠ movieBannerURL ⁠ parameter (or adapt to the updated initializer if it changes).
•⁠  ⁠Update DTO mapping unit tests to validate ⁠ movie_banner ⁠ mapping:
  - FilmDTO.movie_banner string → Film.movieBannerURL (URL?) parsing
  - Ensure nil or invalid URL strings map to nil safely (no crashes).
•⁠  ⁠If any view-model tests use FilmDTO or hardcoded Film fixtures, keep naming consistent (Film/Person only) and update fixtures to compile.
•⁠  ⁠Do NOT add UI snapshot tests or network tests; keep tests deterministic and unit-level only.

Output instructions (VERY IMPORTANT):
1) First output a list of every file you will add
   - Core/Extensions/URL+Validation.swift (new)

Final requirement:
•⁠  ⁠Ensure the app compiles and runs after the changes.
•⁠  ⁠Ensure the unit tests compile and pass after the changes.
•⁠  ⁠Keep Theme tokens in use throughout (no hardcoded colors).


**Result**
- Added support for decoding `movie_banner` in `FilmDTO` and mapping it to Domain (`Film.movieBannerURL`).
- Updated Movie List row UI to show a leading thumbnail using `AsyncImage`.
- Implemented safe fallback: invalid/broken URL shows a built-in SF Symbol placeholder styled via Theme tokens.
- Added/updated unit tests to cover `movie_banner` DTO→Domain mapping and updated any Film fixtures to compile with the new model property.

**Evidence**
- Recording: listing-view-image-prompt.mov

---

### Human Intervention & Engineering Decisions

While Xcode AI generated the initial structure and code, several decisions and refinements were made manually:

- Verified and enforced Clean Architecture boundaries between Presentation, Domain, and Data layers
- Refactored ViewModels to use structured concurrency correctly (async APIs instead of fire-and-forget tasks)
- Improved testability by injecting scheduler and debounce parameters into Combine pipelines
- Wrote and adjusted unit tests to ensure deterministic behavior for async/Combine code
- Reviewed AI-generated code for naming consistency, API correctness, and model alignment

This ensured the final implementation was production-quality, testable, and aligned with best practices.

---

### Prompt Engineering Summary

This project demonstrates effective prompt engineering by:
- Starting with a high-level architectural prompt
- Iteratively refining the output through focused follow-up prompts
- Using AI for generation, debugging, refactoring, and enhancement
- Guiding the AI with constraints (architecture, concurrency rules, layering)
- Validating and correcting AI output through testing and manual review

The result is a working, testable application created through deliberate and controlled AI-assisted development rather than passive code generation.
