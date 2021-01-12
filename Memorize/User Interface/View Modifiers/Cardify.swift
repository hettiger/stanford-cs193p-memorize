//
//  Cardify.swift
//  Memorize
//
//  Created by Martin Hettiger on 12.01.21.
//

import SwiftUI

struct Cardify: ViewModifier {
    let isFaceUp: Bool
    let color: Color

    @ViewBuilder
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isFaceUp {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(faceUpFillColor)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(gradient(.white, for: geometry.size))
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(lineWidth: strokeWidth)
                    content
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(gradient(color, for: geometry.size))
                }
            }
        }
    }

    private func gradient(_ color: Color, for size: CGSize) -> some ShapeStyle {
        RadialGradient(
            gradient: .init(colors: [
                color.opacity(gradientOpacity),
                color,
                color.opacity(gradientOpacity),
            ]),
            center: UnitPoint(x: centerRatio, y: 1 - centerRatio),
            startRadius: 0,
            endRadius: 2 * max(size.width, size.height)
        )
    }

    // MARK: - Drawing Constants

    private let cornerRadius: CGFloat = 10
    private let faceUpFillColor: Color = .init(white: 0.96)
    private let strokeWidth: CGFloat = 3
    private let centerRatio: CGFloat = 2 / 3
    private let gradientOpacity = 0.5
}
