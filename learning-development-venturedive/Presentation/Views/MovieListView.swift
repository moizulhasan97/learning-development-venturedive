//
//  MovieListView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import SwiftUI

struct MovieListView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.theme) private var theme

    @StateObject private var vm: MovieListViewModel

    init(getFilms: GetFilmsUseCase) {
        _vm = StateObject(wrappedValue: MovieListViewModel(getFilms: getFilms))
    }

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Ghibli Films")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        ThemeButton()
                    }
                }
                .background(theme.background.ignoresSafeArea())
        }
        .environment(\.theme, themeManager.current)
        .onAppear { vm.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state {
        case .idle, .loading:
            loadingView
        case .error(let message):
            errorView(message)
        case .loaded:
            listView
        }
    }

    private var searchField: some View {
        TextField("Search films, directors...", text: $vm.query)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, theme.spacingM)
            .padding(.top, theme.spacingM)
    }

    private var listView: some View {
        VStack(spacing: 0) {
            searchField
            if vm.items.isEmpty {
                emptyPrompt("No films available.")
            } else if vm.query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                emptyPrompt("Type to search films.")
            } else if vm.filtered.isEmpty {
                emptyPrompt("No results")
            } else {
                List(vm.filtered) { film in
                    NavigationLink(value: film.id) {
                        FilmRow(film: film)
                    }
                    .listRowBackground(theme.background)
                }
                .listStyle(.plain)
                .navigationDestination(for: String.self) { id in
                    MovieDetailView(id: id)
                }
            }
        }
    }

    private var loadingView: some View {
        VStack(spacing: theme.spacingM) {
            ProgressView().tint(theme.accent)
            Text("Loading films...")
                .font(theme.bodyFont)
                .foregroundStyle(theme.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.background)
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: theme.spacingM) {
            Text("Failed to load films")
                .font(theme.subtitleFont)
                .foregroundStyle(theme.primaryText)
            Text(message)
                .font(theme.bodyFont)
                .foregroundStyle(theme.secondaryText)
                .multilineTextAlignment(.center)
            Button("Retry") {
                Task { await vm.load() }
            }
            .buttonStyle(.borderedProminent)
            .tint(theme.accent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.background)
    }

    private func emptyPrompt(_ text: String) -> some View {
        VStack(spacing: theme.spacingS) {
            Text(text)
                .font(theme.bodyFont)
                .foregroundStyle(theme.secondaryText)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(theme.background)
    }
}

private struct FilmRow: View {
    @Environment(\.theme) private var theme
    let film: Film
    var body: some View {
        HStack(alignment: .center, spacing: theme.spacingM) {
            thumbnail
                .frame(width: 72, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius/2))
            VStack(alignment: .leading, spacing: theme.spacingS) {
                Text(film.title)
                    .font(theme.subtitleFont)
                    .foregroundStyle(theme.primaryText)
                Text(film.originalTitle)
                    .font(.caption)
                    .foregroundStyle(theme.secondaryText)
            }
            Spacer()
        }
        .padding(.vertical, theme.spacingS)
    }

    @ViewBuilder
    private var thumbnail: some View {
        if let url = film.movieBannerURL, url.isHTTPURL {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    placeholder
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure:
                    placeholder
                @unknown default:
                    placeholder
                }
            }
        } else {
            placeholder
        }
    }

    private var placeholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: theme.cornerRadius/2)
                .fill(theme.separator.opacity(0.3))
            Image(systemName: "film")
                .foregroundStyle(theme.secondaryText)
        }
    }
}
