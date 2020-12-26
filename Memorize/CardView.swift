//
//  CardView.swift
//  Memorize
//
//  Created by Martin Hettiger on 26.12.20.
//

import SwiftUI

struct CardView: View {
    enum Constants {
        static let cornerRadius: CGFloat = 10
        static let fillColor: Color = .white
        static let strokeWidth: CGFloat = 3
    }

    var isFaceUp: Bool = false
    var emoji: String

    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Constants.fillColor)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .strokeBorder(lineWidth: Constants.strokeWidth)
                Text(emoji)
            } else {
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill()
            }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(isFaceUp: true, emoji: "👻")
        CardView(isFaceUp: false, emoji: "👻")
    }
}
