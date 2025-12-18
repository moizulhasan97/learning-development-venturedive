# Architecture

## Overview
This app follows **MVVM + Clean layering**:

- **Presentation**
  - SwiftUI Views + ViewModels
  - UI components (loading/empty/error)
  - Theme system (protocol-based)
- **Domain**
  - Entities (e.g., Film, Person)
  - Use cases (e.g., GetFilms, GetFilmDetail, GetPeople)
  - Repository protocols (abstractions)
- **Data**
  - API clients (URLSession, async/await)
  - DTOs (Decodable)
  - Repository implementations + DTO → Domain mapping

Goal: keep UI independent from networking details, and keep Domain independent from frameworks.

---

## API Usage
Studio Ghibli API (no authentication):
- `GET /films` — list
- `GET /films/{id}` — detail
- `GET /people` — cast/people

Detail screen intentionally performs additional API calls to demonstrate multi-endpoint networking.

---

## Search Strategy
The film search is **client-side**:
- films are fetched once using async/await
- search query is debounced in ViewModel using Combine
- filtering is case-insensitive and trims whitespace

This reduces network calls and clearly demonstrates Combine usage.

---

## Concurrency
- All networking uses `async/await`
- ViewModels that mutate UI state run on the main actor (`@MainActor`)
- Detail screen loads film detail and cast with independent loading/error states

---

## Error Handling
Networking uses a typed `APIError` that maps:
- URL construction failures
- transport/network failures
- HTTP status failures
- decoding failures

Presentation surfaces user-friendly messages via view states.
