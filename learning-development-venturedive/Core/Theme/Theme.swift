//
//  Theme.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 18/12/2025.
//


import SwiftUI

public protocol Theme {
    var name: String { get }
    // Colors
    var background: Color { get }
    var primaryText: Color { get }
    var secondaryText: Color { get }
    var accent: Color { get }
    var separator: Color { get }
    // Typography
    var titleFont: Font { get }
    var subtitleFont: Font { get }
    var bodyFont: Font { get }
    // Spacing & Radius
    var spacingS: CGFloat { get }
    var spacingM: CGFloat { get }
    var spacingL: CGFloat { get }
    var cornerRadius: CGFloat { get }
}
