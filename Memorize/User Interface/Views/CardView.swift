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
        if card.isFaceUp || !card.isMatched {
            GeometryReader { geometry in
                ZStack {
                    Pie(
                        startAngle: Angle.degrees(0 - 90),
                        endAngle: Angle.degrees(110 - 90),
                        clockwise: true
                    )
                    .padding(piePadding)
                    .opacity(pieOpacity)
                    Text(String(card.content))
                        .font(font(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(
                            card.isMatched
                                ? Animation.linear(duration: 2).repeatForever(autoreverses: false)
                                : .default
                        )
                }
                .modifier(Cardify(
                    isFaceUp: card.isFaceUp,
                    color: game.theme.color
                ))
            }
        }
    }

    private func font(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * fontSizeFactor)
    }

    // MARK: - Drawing Constants

    private let fontSizeFactor: CGFloat = 1 / 2
    private let piePadding: CGFloat = 8
    private let pieOpacity: Double = 0.4
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(id: 0, content: "👻", isFaceUp: true))
                .foregroundColor(.orange)
            CardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
    }
}
