//
//  MovieDetailView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import SwiftUI

struct MovieDetailView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.theme) private var theme

    let id: String
    @StateObject private var vm: MovieDetailViewModel

    init(id: String) {
        self.id = id
        let filmRepo = RemoteFilmRepository()
        let peopleRepo = RemotePeopleRepository()
        _vm = StateObject(wrappedValue: MovieDetailViewModel(
            getFilmDetail: DefaultGetFilmDetailUseCase(repository: filmRepo),
            getPeople: DefaultGetPeopleUseCase(repository: peopleRepo)
        ))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                switch vm.filmState {
                case .idle, .loading:
                    // Header skeleton placeholder
                    RoundedRectangle(cornerRadius: theme.cornerRadius)
                        .fill(theme.separator.opacity(0.3))
                        .frame(height: 220)
                        .padding()
                        .redacted(reason: .placeholder)
                        .shimmerPlaceholder()
                case .failed:
                    EmptyView()
                case .loaded(let film):
                    StretchyHeaderView(url: film.movieBannerURL)
                        .frame(height: 220)
                        .padding(.horizontal)
                        .transition(.opacity)
                }

                VStack(alignment: .leading, spacing: theme.spacingL) {
                    filmSection
                    castSection
                }
                .padding()
            }
        }
        .background(theme.background.ignoresSafeArea())
        .navigationTitle("Details")
        .task(id: id) {
            await vm.load(id: id)
        }
        .environment(\.theme, themeManager.current)
    }

    @ViewBuilder
    private var filmSection: some View {
        switch vm.filmState {
        case .idle, .loading:
            VStack(alignment: .leading, spacing: theme.spacingS) {
                SkeletonTextLines(lines: 3)
            }
            .transition(.opacity)
        case .failed(let msg):
            VStack(alignment: .leading, spacing: theme.spacingS) {
                Text("Failed to load film").foregroundStyle(theme.primaryText)
                Text(msg).foregroundStyle(theme.secondaryText)
                Button("Retry") {
                    Task {
                        await vm.load(id: id)
                    }
                }.tint(theme.accent)
            }
        case .loaded(let film):
            VStack(alignment: .leading, spacing: theme.spacingM) {
                VStack(alignment: .leading, spacing: theme.spacingS) {
                    Text(film.title)
                        .font(theme.titleFont)
                        .foregroundStyle(theme.primaryText)
                    Text(film.originalTitle)
                        .font(theme.subtitleFont)
                        .foregroundStyle(theme.secondaryText)
                    ScoreRingView(score: Double(film.rtScore) ?? 0)
                        .frame(width: 72, height: 72)
                }
                Text(film.description)
                    .font(theme.bodyFont)
                    .foregroundStyle(theme.primaryText)
                infoRow(label: "Director", value: film.director)
                infoRow(label: "Producer", value: film.producer)
                infoRow(label: "Release", value: film.releaseDate)
                infoRow(label: "Running", value: film.runningTime + " min")
                infoRow(label: "RT Score", value: film.rtScore)
            }
        }
    }

    @ViewBuilder
    private var castSection: some View {
        VStack(alignment: .leading, spacing: theme.spacingS) {
            Text("Cast").font(theme.subtitleFont).foregroundStyle(theme.primaryText)
            switch vm.castState {
            case .idle, .loading:
                ForEach(0..<4, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: theme.cornerRadius / 3)
                        .fill(theme.separator.opacity(0.3))
                        .frame(height: 16)
                        .padding(.vertical, 4)
                        .redacted(reason: .placeholder)
                        .shimmerPlaceholder()
                }
            case .failed(let msg):
                VStack(alignment: .leading, spacing: theme.spacingS) {
                    Text("Failed to load cast").foregroundStyle(theme.primaryText)
                    Text(msg).foregroundStyle(theme.secondaryText)
                    Button("Retry") {
                        Task {
                            await vm.load(id: id)
                        }
                    }.tint(theme.accent)
                }
            case .loaded(let cast):
                if cast.isEmpty {
                    Text("No cast found").foregroundStyle(theme.secondaryText)
                } else {
                    ForEach(cast) { person in
                        Text(person.name)
                            .font(theme.bodyFont)
                            .foregroundStyle(theme.primaryText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 4)
                        Divider().background(theme.separator)
                    }
                }
            }
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label + ":").foregroundStyle(theme.secondaryText)
            Text(value).foregroundStyle(theme.primaryText)
        }
        .font(theme.bodyFont)
    }
}
private struct ShimmerPlaceholder: ViewModifier {
    @State private var on = false
    func body(content: Content) -> some View {
        content
            .opacity(on ? 0.6 : 1.0)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                    on = true
                }
            }
    }
}
private extension View {
    func shimmerPlaceholder() -> some View {
        modifier(ShimmerPlaceholder())
    }
}

