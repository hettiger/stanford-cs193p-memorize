//
//  CardView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var game = EmojiMemoryGame.shared

    var card: MemoryGame<Character>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: CardView.cornerRadius)
                        .fill(gradient(CardView.faceUpFillColor, for: geometry.size))
                    RoundedRectangle(cornerRadius: CardView.cornerRadius)
                        .strokeBorder(lineWidth: CardView.strokeWidth)
                    Text(String(card.content))
                } else if !card.isMatched {
                    RoundedRectangle(cornerRadius: CardView.cornerRadius)
                        .fill(gradient(game.theme.color, for: geometry.size))
                }
            }
            .font(font(for: geometry.size))
        }
        .aspectRatio(CardView.aspectRatio, contentMode: .fit)
    }

    private func font(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * CardView.aspectRatio)
    }

    private func gradient(_ color: Color, for size: CGSize) -> some ShapeStyle {
        RadialGradient(
            gradient: .init(colors: [
                self.color(color, for: .translucent),
                self.color(color, for: .opaque),
                self.color(color, for: .translucent),
            ]),
            center: UnitPoint(x: CardView.aspectRatio, y: 1 - CardView.aspectRatio),
            startRadius: 0,
            endRadius: max(size.width, size.height)
        )
    }

    private func color(_ color: Color, for type: GradientColorType) -> Color {
        switch type {
        case .opaque:
            return color.opacity(1)
        case .translucent:
            return color.opacity(CardView.translucentOpacity)
        }
    }

    private enum GradientColorType {
        case opaque, translucent
    }

    // MARK: - Drawing Constants

    static let cornerRadius: CGFloat = 10
    static let faceUpFillColor: Color = .init(white: 0.96)
    static let strokeWidth: CGFloat = 3
    static let aspectRatio: CGFloat = 2 / 3
    static let translucentOpacity: Double = 3 / 4
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(id: 0, content: "👻", isFaceUp: true))
            CardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
    }
}
