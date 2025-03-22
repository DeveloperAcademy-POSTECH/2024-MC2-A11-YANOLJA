//
//  DarkBlurView.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/21/25.
//

import SwiftUI
import UIKit

struct DarkBlurView: UIViewRepresentable {
  var blurRadius: CGFloat
  
  func makeUIView(context: Context) -> UIVisualEffectView {
    let blurEffect = UIBlurEffect(style: .systemThinMaterialDark)
    let blurView = UIVisualEffectView(effect: blurEffect)
    
    if let blurEffectSubView = blurView.subviews.first(where: { String(describing: type(of: $0)).contains("VisualEffectSubview") }) {
      blurEffectSubView.layer.filters = [makeBlurFilter()]
    }
    
    return blurView
  }
  
  func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
  
  private func makeBlurFilter() -> CIFilter {
    let filter = CIFilter(name: "CIGaussianBlur")!
    filter.setValue(blurRadius, forKey: kCIInputRadiusKey)
    return filter
  }
}
