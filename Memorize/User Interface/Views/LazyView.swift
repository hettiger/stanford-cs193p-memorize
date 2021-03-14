//
//  LazyView.swift
//  Memorize
//
//  Created by Martin Hettiger on 14.03.21.
//

import SwiftUI

/// Wraps a view to make it load lazily e.g. in a `NavigationLink`
///
/// - See: https://www.objc.io/blog/2019/07/02/lazy-loading/
struct LazyView<Content: View>: View {
    let build: () -> Content

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }

    var body: Content {
        build()
    }
}
