//
//  Shape+DashedLine.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import SwiftUI

struct Line: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.move(to: CGPoint(x: 0, y: 0))
      path.addLine(to: CGPoint(x: 0, y: rect.height))
    }
  }
}

extension Shape {
  func dashed(
    color: Color = Color(.systemGray3),
    lineWidth: CGFloat = 2,
    dash: [CGFloat] = [4.9, 9.8]
  ) -> some View {
    self.stroke(
      color,
      style: StrokeStyle(
        lineWidth: lineWidth,
        lineCap: .round,
        dash: dash
      )
    )
  }
}
