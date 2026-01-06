//
//  ThemeManaging.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import SwiftUI
import Combine

public protocol ThemeManaging: AnyObject {
    var current: Theme { get }
    func set(theme: Theme)
}

public final class ThemeManager: ObservableObject, ThemeManaging {
    @Published public private(set) var current: Theme
    private let storageKey = "SelectedThemeName"

    public init() {
        let saved = UserDefaults.standard.string(forKey: storageKey)
        switch saved {
        case DarkTheme().name: current = DarkTheme()
        case CinemaTheme().name: current = CinemaTheme()
        default: current = LightTheme()
        }
    }

    public func set(theme: Theme) {
        withAnimation(.easeInOut) {
            self.current = theme
            UserDefaults.standard.set(theme.name, forKey: storageKey)
        }
    }
}

private struct ThemeKey: EnvironmentKey {
    static let defaultValue: Theme = LightTheme()
}

public extension EnvironmentValues {
    var theme: Theme {
        get { self[ThemeKey.self] }
        set { self[ThemeKey.self] = newValue }
    }
}
