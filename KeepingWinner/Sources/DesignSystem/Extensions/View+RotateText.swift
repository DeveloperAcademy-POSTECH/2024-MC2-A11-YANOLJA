//
//  View+RotateText.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import Foundation
import SwiftUI

extension View {
  func rotated(_ angle: Angle = .degrees(90)) -> some View {
    Rotated(self, angle: angle)
  }
}

private struct SizeKey: PreferenceKey {
  static let defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    value = nextValue()
  }
}

extension View {
  func captureSize(in binding: Binding<CGSize>) -> some View {
    overlay(GeometryReader { proxy in
      Color.clear.preference(key: SizeKey.self, value: proxy.size)
    })
    .onPreferenceChange(SizeKey.self) { size in binding.wrappedValue = size }
  }
}

struct Rotated<Rotated: View>: View {
  var view: Rotated
  var angle: Angle
  
  init (_ view: Rotated, angle: Angle = .degrees(90)) {
    self.view = view
    self.angle = angle
  }
  
  @State private var size: CGSize = .zero
  
  var body: some View {
    let newFrame = CGRect(origin: .zero, size: size)
      .offsetBy(dx: size.width/2, dy: size.height/2)
      .applying(.init(rotationAngle: CGFloat(angle.radians)))
      .integral
    
    return view
      .fixedSize()
      .captureSize(in: $size)
      .rotationEffect(angle)
      .frame(width: newFrame.width, height: newFrame.height)
  }
}
