//
//  Pie.swift
//  Memorize
//
//  Created by Alvin Liang on 2022-06-16.
//

import SwiftUI

struct Pie: Shape{
     var startAngle: Angle
     var endAngle: Angle
     var clockwise: Bool = false
        
    func path(in rect: CGRect) -> Path {
       
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        //CGRect represents the space that is available to us to draw
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        
        )
        var p = Path()
        //in here we're going to have to call some functions onto our path in order to have it draw shapes
        p.move(to: center)
        p.addLine(to:start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: !clockwise)
        p.addLine(to: center)
        return p
    }
}
