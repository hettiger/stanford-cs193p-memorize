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
                    RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor)
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .strokeBorder(lineWidth: strokeWidth)
                    Text(card.content)
                } else if !card.isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                }
            }
            .font(font(for: geometry.size))
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
    }

    func font(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * aspectRatio)
    }

    // MARK: - Drawing Constants

    let cornerRadius: CGFloat = 10
    let fillColor: Color = .white
    let strokeWidth: CGFloat = 3
    let aspectRatio: CGFloat = 2 / 3
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: .init(id: 0, content: "👻", isFaceUp: true))
            CardView(card: .init(id: 1, content: "👻", isFaceUp: false))
        }
    }
}
