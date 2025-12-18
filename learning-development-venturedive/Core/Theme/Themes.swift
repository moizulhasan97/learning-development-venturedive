//
//  Themes.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//

import SwiftUI

public struct LightTheme: Theme {
    public let name = "Light"
    public var background: Color { Color(.systemBackground) }
    public var primaryText: Color { Color.primary }
    public var secondaryText: Color { Color.secondary }
    public var accent: Color { .blue }
    public var separator: Color { Color(.separator) }
    public var titleFont: Font { .title2.weight(.semibold) }
    public var subtitleFont: Font { .headline }
    public var bodyFont: Font { .body }
    public var spacingS: CGFloat { 6 }
    public var spacingM: CGFloat { 12 }
    public var spacingL: CGFloat { 20 }
    public var cornerRadius: CGFloat { 12 }
    public init() {}
}

public struct DarkTheme: Theme {
    public let name = "Dark"
    public var background: Color { Color.black }
    public var primaryText: Color { Color.white }
    public var secondaryText: Color { Color.gray }
    public var accent: Color { .orange }
    public var separator: Color { Color.gray.opacity(0.4) }
    public var titleFont: Font { .title2.weight(.bold) }
    public var subtitleFont: Font { .headline }
    public var bodyFont: Font { .body }
    public var spacingS: CGFloat { 6 }
    public var spacingM: CGFloat { 12 }
    public var spacingL: CGFloat { 20 }
    public var cornerRadius: CGFloat { 14 }
    public init() {}
}

public struct CinemaTheme: Theme {
    public let name = "Cinema"
    public var background: Color { Color(red: 0.05, green: 0.07, blue: 0.10) }
    public var primaryText: Color { Color(red: 0.95, green: 0.92, blue: 0.85) }
    public var secondaryText: Color { Color(red: 0.80, green: 0.78, blue: 0.72) }
    public var accent: Color { Color(red: 0.85, green: 0.2, blue: 0.2) }
    public var separator: Color { Color.white.opacity(0.15) }
    public var titleFont: Font { .largeTitle.weight(.semibold) }
    public var subtitleFont: Font { .title3 }
    public var bodyFont: Font { .body }
    public var spacingS: CGFloat { 8 }
    public var spacingM: CGFloat { 14 }
    public var spacingL: CGFloat { 24 }
    public var cornerRadius: CGFloat { 16 }
    public init() {}
}
