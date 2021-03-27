//
//  EditableListRowIndicator.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.03.21.
//

import SwiftUI

struct EditableListRowIndicator: View {
    var color: Color

    var body: some View {
        ZStack {
            Image(systemName: "pencil")
                .imageScale(.small)
                .padding(4)
                .foregroundColor(.white)
                .background(color.clipShape(Circle()))
        }
        .padding(.trailing, 16)
        .frame(maxHeight: .infinity)
        .transition(
            AnyTransition.opacity.animation(Animation.linear)
                .combined(with: AnyTransition.move(edge: .leading)
                    .animation(Animation.easeInOut))
        )
        // Use backgrounds with offsets to workaround missing list separator modifier
        .background(
            Color.white.frame(height: 0.5).offset(x: 0, y: -6.5),
            alignment: .top
        )
        .background(
            Color.white.frame(height: 0.5).offset(x: 0, y: 6),
            alignment: .bottom
        )
    }
}

struct EditIndicator_Previews: PreviewProvider {
    static var previews: some View {
        EditableListRowIndicator(color: .orange)
    }
}
