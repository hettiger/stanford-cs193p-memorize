//
//  Color+lightened+darkened.swift
//  Memorize
//
//  Created by Martin Hettiger on 03.01.21.
//

import SwiftUI

extension Color {
    /// Returns lightened copy of `self`
    ///
    /// - Parameter amount: A value between 0 (no effect) and 1 (full white) that represents the intensity of the lighten effect.
    func lightened(by amount: CGFloat) -> Color {
        return Color(UIColor(self).lightened(by: amount))
    }

    /// Returns darkened copy of `self`
    ///
    /// - Parameter amount: A value between 0 (no effect) and 1 (full black) that represents the intensity of the darken effect.
    func darkened(by amount: CGFloat) -> Color {
        return Color(UIColor(self).darkened(by: amount))
    }
}

extension UIColor {
    /// Returns lightened copy of `self`
    ///
    /// - Parameter amount: A value between 0 (no effect) and 1 (full white) that represents the intensity of the lighten effect.
    func lightened(by amount: CGFloat) -> UIColor {
        guard var hsla = hsla else { return self }
        hsla.l += amount * (1 - hsla.l)
        return UIColor(hsla: hsla)
    }

    /// Returns darkened copy of `self`
    ///
    /// - Parameter amount: A value between 0 (no effect) and 1 (full black) that represents the intensity of the darken effect.
    func darkened(by amount: CGFloat) -> UIColor {
        guard var hsla = hsla else { return self }
        hsla.l -= amount * hsla.l
        return UIColor(hsla: hsla)
    }

    // MARK: - Color Space Conversion

    fileprivate var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat)? {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return nil }
        return (h, s, b, a)
    }

    fileprivate var hsla: (h: CGFloat, s: CGFloat, l: CGFloat, a: CGFloat)? {
        guard let (h, s, b, a) = hsba else { return nil }
        var hh = h, ss: CGFloat, ll: CGFloat, aa = a
        ll = (2 - s) * b
        ss = s * b
        ss /= (ll <= 1) ? ll : 2 - ll
        ll /= 2
        return (hh, ss, ll, aa)
    }

    fileprivate convenience init(hsla: (h: CGFloat, s: CGFloat, l: CGFloat, a: CGFloat)) {
        var (h, s, l, a) = hsla
        var hh = h, ss: CGFloat, bb: CGFloat, aa = a
        l *= 2
        s *= (l <= 1) ? l : 2 - l
        bb = (l + s) / 2
        ss = (2 * s) / (l + s)
        self.init(hue: hh, saturation: ss, brightness: bb, alpha: aa)
    }
}
