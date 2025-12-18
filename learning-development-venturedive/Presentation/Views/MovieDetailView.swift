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
            VStack(alignment: .leading, spacing: theme.spacingL) {
                filmSection
                castSection
            }
            .padding()
        }
        .background(theme.background.ignoresSafeArea())
        .navigationTitle("Details")
        .onAppear { vm.load(id: id) }
        .environment(\.theme, themeManager.current)
    }

    @ViewBuilder
    private var filmSection: some View {
        switch vm.filmState {
        case .idle, .loading:
            HStack { ProgressView().tint(theme.accent); Text("Loading film...").foregroundStyle(theme.secondaryText) }
        case .failed(let msg):
            VStack(alignment: .leading, spacing: theme.spacingS) {
                Text("Failed to load film").foregroundStyle(theme.primaryText)
                Text(msg).foregroundStyle(theme.secondaryText)
                Button("Retry") { vm.load(id: id) }.tint(theme.accent)
            }
        case .loaded(let film):
            VStack(alignment: .leading, spacing: theme.spacingM) {
                Text(film.title).font(theme.titleFont).foregroundStyle(theme.primaryText)
                Text(film.originalTitle).font(theme.subtitleFont).foregroundStyle(theme.secondaryText)
                Text(film.description).font(theme.bodyFont).foregroundStyle(theme.primaryText)
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
                HStack { ProgressView().tint(theme.accent); Text("Loading cast...").foregroundStyle(theme.secondaryText) }
            case .failed(let msg):
                VStack(alignment: .leading, spacing: theme.spacingS) {
                    Text("Failed to load cast").foregroundStyle(theme.primaryText)
                    Text(msg).foregroundStyle(theme.secondaryText)
                    Button("Retry") { vm.load(id: id) }.tint(theme.accent)
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
