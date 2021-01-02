//
//  CommandLine+Arguments.swift
//  Memorize
//
//  Created by Martin Hettiger on 02.01.21.
//

import Foundation

#if DEBUG
    extension CommandLine {
        enum Argument: String {
            case resetUserDefaults
        }
    }
#endif
