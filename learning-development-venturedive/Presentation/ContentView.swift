//
//  ContentView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var themeManager = ThemeManager()

    var body: some View {
        MovieListView(getFilms: DefaultGetFilmsUseCase(repository: RemoteFilmRepository()))
            .environmentObject(themeManager)
    }
}

#Preview {
    ContentView()
}
