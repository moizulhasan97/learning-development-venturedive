//
//  ScoreRingView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 06/01/2026.
//


import SwiftUI

struct ScoreRingView: View {
    @Environment(\.theme) var theme
    let score: Double
    
    private var progress: Double {
        min(max(score / 100, 0), 1)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(theme.separator, lineWidth: 6)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(theme.accent, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 0.8), value: progress)
            Text("\(Int(score))")
                .font(theme.bodyFont)
                .foregroundColor(theme.primaryText)
        }
        .frame(width: 64, height: 64)
    }
}

