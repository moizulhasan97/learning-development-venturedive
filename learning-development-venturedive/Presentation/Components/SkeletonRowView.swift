//
//  SkeletonRowView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 06/01/2026.
//


import SwiftUI

struct SkeletonRowView: View {
    @Environment(\.theme) private var theme
    
    @State private var isAnimating = false
    
    var body: some View {
        HStack(spacing: theme.spacingM) {
            RoundedRectangle(cornerRadius: 4)
                .fill(theme.separator.opacity(0.3))
                .frame(width: 72, height: 44)
                .opacity(isAnimating ? 1.0 : 0.6)
            
            VStack(alignment: .leading, spacing: theme.spacingS / 2) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(theme.separator.opacity(0.3))
                    .frame(height: 16)
                    .frame(maxWidth: .infinity)
                    .opacity(isAnimating ? 1.0 : 0.6)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(theme.separator.opacity(0.3))
                    .frame(height: 12)
                    .frame(maxWidth: .infinity)
                    .opacity(isAnimating ? 1.0 : 0.6)
            }
        }
        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}
