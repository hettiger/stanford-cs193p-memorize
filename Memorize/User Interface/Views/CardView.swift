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
                    Pie(
                        startAngle: Angle.degrees(0 - 90),
                        endAngle: Angle.degrees(110 - 90),
                        clockwise: true
                    )
                    .padding(CardView.piePadding)
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
        .system(size: min(size.width, size.height) * CardView.fontSizeFactor)
    }

    private func gradient(_ color: Color, for size: CGSize) -> some ShapeStyle {
        RadialGradient(
            gradient: .init(colors: [
                color.lightened(by: CardView.lightenAmount),
                color,
                color.lightened(by: CardView.lightenAmount),
            ]),
            center: UnitPoint(x: CardView.aspectRatio, y: 1 - CardView.aspectRatio),
            startRadius: 0,
            endRadius: 2 * max(size.width, size.height)
        )
    }

    // MARK: - Drawing Constants

    static let cornerRadius: CGFloat = 10
    static let faceUpFillColor: Color = .init(white: 0.96)
    static let strokeWidth: CGFloat = 3
    static let aspectRatio: CGFloat = 2 / 3
    static let fontSizeFactor: CGFloat = 1 / 2
    static let piePadding: CGFloat = 8
    static let lightenAmount: CGFloat = 0.5
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(id: 0, content: "👻", isFaceUp: true))
            CardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
    }
}
