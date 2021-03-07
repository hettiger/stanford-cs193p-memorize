//
//  EmojiCardView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI
import Swinject

struct EmojiCardView: View {
    var card: MemoryGame<Character>.Card

    @EnvironmentObject
    private var game: EmojiMemoryGame

    @State
    private var animatedBonusRemaining: Double = 0

    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(
                                startAngle: Angle.degrees(0 - 90),
                                endAngle: Angle.degrees(-animatedBonusRemaining * 360 - 90),
                                clockwise: true
                            )
                            .onAppear(perform: startBonusTimeAnimation)
                        } else {
                            Pie(
                                startAngle: Angle.degrees(0 - 90),
                                endAngle: Angle.degrees(-card.bonusRemaining * 360 - 90),
                                clockwise: true
                            )
                        }
                    }
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
                .cardify(isFaceUp: card.isFaceUp, color: game.theme.color)
                .transition(.scale)
            }
        }
    }

    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
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
        let container = ContainerFactory.makeEmojiMemoryGameContainer()
        let emojiMemoryGame = container.resolve(EmojiMemoryGame.self)!

        Group {
            EmojiCardView(card: .init(id: 0, content: "👻", isFaceUp: true))
                .foregroundColor(.orange)
            EmojiCardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
        .padding()
        .environmentObject(emojiMemoryGame)
    }
}
