# Ghibli Movie Browser 🎬

A modern iOS application built with **SwiftUI**, **Combine**, and **structured concurrency (async/await)**, showcasing **Clean Architecture**, **deterministic unit testing**, and **responsible AI-assisted development using Xcode 26 Coding Intelligence**.

This project was created as part of a learning and development initiative to explore how AI tooling can be integrated into real-world iOS engineering workflows while maintaining architectural discipline and code quality.

---

## ✨ Features

- **Movie List**
  - Fetches Studio Ghibli films using async/await
  - Client-side debounced search using Combine
  - Loading, empty, error, and skeleton states
  - Banner image thumbnails with graceful fallback

- **Movie Detail**
  - Fetches film detail and cast using multiple API endpoints
  - Independent loading and error states
  - Stretchy hero header using movie banner image
  - Animated score visualization

- **Visual Enhancements**
  - Skeleton loaders instead of spinners
  - SwiftUI-native animations and transitions
  - Theme-aware UI (no hardcoded colors)

- **Theme System**
  - Protocol-based theming
  - Light, Dark, and Cinema themes
  - Runtime theme switching with persistence

- **Robust Error Handling**
  - Typed `APIError`
  - User-friendly error messaging in the UI

- **Unit Testing**
  - Domain, Presentation, and Data mapping tests
  - Deterministic async/await and Combine testing
  - No real networking or flaky time-based tests

---

## 🧠 Architecture

The app follows **MVVM + Clean Architecture**:

```
Presentation
 ├─ SwiftUI Views
 ├─ ViewModels
 ├─ Theme system
 └─ UI components (loading / empty / skeleton)

Domain
 ├─ Entities (Film, Person)
 ├─ Use Cases
 └─ Repository protocols

Data
 ├─ API Client (URLSession + async/await)
 ├─ DTOs
 └─ Repository implementations + mapping
```

**Key principles**
- Presentation depends only on Domain
- Domain is framework-agnostic
- Data layer handles all networking and decoding
- DTOs never leak into the UI

---

## 🌐 API

Uses the **Studio Ghibli public API** (no authentication required):

- `GET /films` — list of films
- `GET /films/{id}` — film detail
- `GET /people` — cast / characters

The detail screen intentionally performs multiple API calls to demonstrate multi-endpoint networking and independent loading states.

---

## 🤖 AI-Assisted Development

This project was built using **Xcode 26 Coding Intelligence** with a **prompt-driven, iterative workflow**.

AI was used to:
- Generate initial architecture-aligned code
- Fix compilation issues without breaking layering
- Introduce typed error handling
- Add deterministic unit tests
- Enhance UI visuals and interactions

All AI-generated code was **reviewed, corrected, and validated manually** to ensure:
- Clean Architecture boundaries
- Correct async and Combine usage
- Testability and maintainability

Detailed prompt history and evidence are documented in:
- `Docs/prompts.md`
- `Docs/architecture.md`
- `Docs/recordings.md`

---

## 🧪 Testing

- Built with **XCTest**
- Covers:
  - Domain use cases
  - ViewModel state transitions
  - Search filtering logic
  - DTO → Domain mapping
- No real network calls
- No sleeps or timing-based flakiness

Run tests with:

```
⌘ + U
```

---

## 🛠 Tech Stack

- SwiftUI
- Combine
- Structured Concurrency (async/await)
- XCTest
- Xcode 26 Coding Intelligence
- No third-party dependencies

---

## 🚀 Getting Started

1. Clone the repository
2. Open the project in **Xcode 26**
3. Build and run on the iOS Simulator
4. Explore search, themes, and detail views

---

## 📌 Purpose

This repository serves as:
- A reference implementation of modern iOS architecture
- A demonstration of responsible AI-assisted development
- A learning artifact for async/await, Combine, and testability in SwiftUI

It is not intended as a production app.

---

## 📄 License

Provided for educational and demonstration purposes.
