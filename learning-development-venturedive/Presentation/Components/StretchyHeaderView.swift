//
//  StretchyHeaderView.swift
//  learning-development-venturedive
//
//  Created by Moiz Ul Hasan on 06/01/2026.
//


import SwiftUI

struct StretchyHeaderView: View {
    @Environment(\.theme) var theme
    let url: URL?
    
    var body: some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .global).minY
            let baseHeight: CGFloat = 220
            
            ZStack(alignment: .bottom) {
                if let url = url, url.isHTTPURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Color.clear
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            placeholderView
                        @unknown default:
                            placeholderView
                        }
                    }
                } else {
                    placeholderView
                }
                
                LinearGradient(
                    colors: [.clear, theme.background.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 80)
                .frame(maxWidth: .infinity)
                .clipped()
                .allowsHitTesting(false)
            }
            .frame(width: proxy.size.width, height: minY > 0 ? baseHeight + minY : baseHeight)
            .offset(y: minY > 0 ? -minY : 0)
            .clipped()
            .clipShape(RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous))
        }
        .frame(height: 220)
    }
    
    private var placeholderView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: theme.cornerRadius, style: .continuous)
                .fill(theme.background)
            Image(systemName: "film")
                .font(.largeTitle)
                .foregroundColor(theme.secondaryText)
        }
    }
}
