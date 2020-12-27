//
//  String+IntSubscript.swift
//  Memorize
//
//  Created by Martin Hettiger on 27.12.20.
//

import Foundation

extension String {
    subscript(index: Int) -> String {
        String(self[self.index(startIndex, offsetBy: index)])
    }
}
