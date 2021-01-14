//
//  Cardify.swift
//  Memorize
//
//  Created by Martin Hettiger on 12.01.21.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    let color: Color

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    var isFaceUp: Bool {
        rotation < 90
    }

    var rotation = 0.0

    init(isFaceUp: Bool, color: Color) {
        self.color = color
        rotation = isFaceUp ? 0 : 180
    }

    @ViewBuilder
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                Group {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(gradient(faceUpFillColor, for: geometry.size))
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(lineWidth: strokeWidth)
                    content
                }
                .opacity(isFaceUp ? 1 : 0)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(gradient(color, for: geometry.size))
                    .opacity(isFaceUp ? 0 : 1)
            }
            .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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

// MARK: - View Extension

extension View {
    func cardify(isFaceUp: Bool, color: Color) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp, color: color))
    }
}
