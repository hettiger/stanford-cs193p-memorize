//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Martin Hettiger on 30.12.20.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(of element: Element) -> Index? {
        firstIndex(with: element.id)
    }

    func firstIndex(with id: Element.ID) -> Index? {
        firstIndex { id == $0.id }
    }

    func first(with id: Element.ID) -> Element? {
        first { id == $0.id }
    }
}
