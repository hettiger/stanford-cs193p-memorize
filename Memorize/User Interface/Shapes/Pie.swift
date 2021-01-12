//
//  Pie.swift
//  Memorize
//
//  Created by Martin Hettiger on 12.01.21.
//

import SwiftUI

struct Pie: Shape {
    let startAngle: Angle
    let endAngle: Angle

    private(set) var clockwise = false

    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * cos(CGFloat(startAngle.radians)),
            y: center.y + radius * sin(CGFloat(startAngle.radians))
        )

        var path = Path()
        path.move(to: center)
        path.addLine(to: start)
        path.addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )

        return path
    }
}
