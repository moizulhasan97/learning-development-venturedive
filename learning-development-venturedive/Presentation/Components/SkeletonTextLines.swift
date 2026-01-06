//
//  SkeletonTextLines.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 06/01/2026.
//


import SwiftUI

struct SkeletonTextLines: View {
    @Environment(\.theme) var theme
    let lines: Int

    @State private var isAnimating = false

    var body: some View {
        VStack(alignment: .leading, spacing: theme.spacingS) {
            ForEach(0..<lines, id: \.self) { index in
                RoundedRectangle(cornerRadius: theme.cornerRadius / 3)
                    .fill(theme.separator.opacity(0.3))
                    .frame(height: 14)
                    .frame(maxWidth: index % 3 == 2 ? UIScreen.main.bounds.width * 0.6 : .infinity, alignment: .leading)
                    .opacity(isAnimating ? 0.3 : 1)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true), value: isAnimating)
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}
