//
//  ThemeButton.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import SwiftUI

struct ThemeButton: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var show = false
    var body: some View {
        Button {
            show = true
        } label: {
            Image(systemName: "paintpalette")
        }
        .sheet(isPresented: $show) {
            ThemeSwitcherView()
                .environmentObject(themeManager)
        }
    }
}

struct ThemeSwitcherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    private let themes: [Theme] = [LightTheme(), DarkTheme(), CinemaTheme()]
    var body: some View {
        NavigationStack {
            List(themes, id: \.name) { theme in
                HStack {
                    VStack(alignment: .leading) {
                        Text(theme.name).font(theme.subtitleFont)
                        Text("Preview text").font(theme.bodyFont).foregroundStyle(theme.secondaryText)
                    }
                    Spacer()
                    if themeManager.current.name == theme.name {
                        Image(systemName: "checkmark").foregroundStyle(theme.accent)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture { themeManager.set(theme: theme) }
            }
            .navigationTitle("Themes")
            .toolbar { 
                ToolbarItem(placement: .cancellationAction) { 
                    Button("Done") { 
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true) 
                    } 
                } 
            }
        }
    }
}
