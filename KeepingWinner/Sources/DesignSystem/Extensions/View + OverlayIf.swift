//
//  View + OverlayIf.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/24/25.
//

import SwiftUI

extension View {
  func overlayIf<Overlay: View>(
    _ condition: Bool,
    alignment: Alignment = .center,
    @ViewBuilder overlay: () -> Overlay
  ) -> some View {
    ZStack(alignment: alignment) {
      self
      if condition {
        overlay()
      }
    }
  }
}
