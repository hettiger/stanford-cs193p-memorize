//
//  CardView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct CardView: View {
    var card: MemoryGame<String>.Card

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: CardView.cornerRadius).fill(CardView.fillColor)
                    RoundedRectangle(cornerRadius: CardView.cornerRadius)
                        .strokeBorder(lineWidth: CardView.strokeWidth)
                    Text(card.content)
                } else if !card.isMatched {
                    RoundedRectangle(cornerRadius: CardView.cornerRadius).fill()
                }
            }
            .font(font(for: geometry.size))
        }
        .aspectRatio(CardView.aspectRatio, contentMode: .fit)
    }

    func font(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * CardView.aspectRatio)
    }

    // MARK: - Drawing Constants

    static let cornerRadius: CGFloat = 10
    static let fillColor: Color = .white
    static let strokeWidth: CGFloat = 3
    static let aspectRatio: CGFloat = 2 / 3
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(id: 0, content: "👻", isFaceUp: true))
            CardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
    }
}
