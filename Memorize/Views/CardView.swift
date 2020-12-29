//
//  CardView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct CardView: View {
    var isFaceUp: Bool = false
    var emoji: String

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: cornerRadius).fill(fillColor)
                RoundedRectangle(cornerRadius: cornerRadius).strokeBorder(lineWidth: strokeWidth)
                Text(emoji)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius).fill()
            }
        }
        .aspectRatio(aspectRatio, contentMode: .fit)
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
            CardView(isFaceUp: true, emoji: "👻")
            CardView(isFaceUp: false, emoji: "👻")
        }
    }
}
