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
                    .padding(CardView.piePadding)
                    .opacity(CardView.pieOpacity)
                    Text(String(card.content))
                        .font(font(for: geometry.size))
                }
                .modifier(Cardify(
                    isFaceUp: card.isFaceUp,
                    color: game.theme.color
                ))
            }
        }
    }

    private func font(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * CardView.fontSizeFactor)
    }

    // MARK: - Drawing Constants

    static let fontSizeFactor: CGFloat = 1 / 2
    static let piePadding: CGFloat = 8
    static let pieOpacity: Double = 0.4
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
