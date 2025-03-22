//
//  UIImage+ClippedImage.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import UIKit

extension UIImage {
  func clipped(cornerRadius: CGFloat) -> UIImage {
    let rect = CGRect(origin: .zero, size: self.size)
    let renderer = UIGraphicsImageRenderer(size: self.size)
    
    return renderer.image { _ in
      let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
      path.addClip()
      
      UIColor.white.setFill()
      UIRectFill(rect)
      
      self.draw(in: rect)
    }
  }
}
