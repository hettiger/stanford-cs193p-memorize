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
                    RoundedRectangle(cornerRadius: Cardify.cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: Cardify.cornerRadius)
                        .fill(gradient(.white, for: geometry.size))
                    RoundedRectangle(cornerRadius: Cardify.cornerRadius)
                        .strokeBorder(lineWidth: Cardify.strokeWidth)
                    content
                } else {
                    RoundedRectangle(cornerRadius: Cardify.cornerRadius)
                        .fill(Color.white)
                    RoundedRectangle(cornerRadius: Cardify.cornerRadius)
                        .fill(gradient(color, for: geometry.size))
                }
            }
        }
        .aspectRatio(Cardify.aspectRatio, contentMode: .fit)
    }

    private func gradient(_ color: Color, for size: CGSize) -> some ShapeStyle {
        RadialGradient(
            gradient: .init(colors: [
                color.lightened(by: Cardify.lightenAmount),
                color,
                color.lightened(by: Cardify.lightenAmount),
            ]),
            center: UnitPoint(x: Cardify.aspectRatio, y: 1 - Cardify.aspectRatio),
            startRadius: 0,
            endRadius: 2 * max(size.width, size.height)
        )
    }

    // MARK: - Drawing Constants

    static let cornerRadius: CGFloat = 10
    static let faceUpFillColor: Color = .init(white: 0.96)
    static let strokeWidth: CGFloat = 3
    static let aspectRatio: CGFloat = 2 / 3
    static let lightenAmount: CGFloat = 0.5
}
