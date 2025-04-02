//
//  View+UIImage.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import SwiftUI

extension View {
  func asUIImage(size: CGSize) -> UIImage {
    let hosting = UIHostingController(rootView: self)
    hosting.view.bounds = CGRect(origin: .zero, size: size)
    hosting.view.backgroundColor = .clear
    hosting.view.translatesAutoresizingMaskIntoConstraints = false
    hosting.view.insetsLayoutMarginsFromSafeArea = false
    
    let container = UIView(frame: CGRect(origin: .zero, size: size))
    container.backgroundColor = .clear
    container.addSubview(hosting.view)
    
    NSLayoutConstraint.activate([
      hosting.view.topAnchor.constraint(equalTo: container.topAnchor),
      hosting.view.bottomAnchor.constraint(equalTo: container.bottomAnchor),
      hosting.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      hosting.view.trailingAnchor.constraint(equalTo: container.trailingAnchor)
    ])
    
    container.layoutIfNeeded()
    
    let renderer = UIGraphicsImageRenderer(size: size)
    return renderer.image { _ in
      container.drawHierarchy(in: container.bounds, afterScreenUpdates: true)
    }
  }
}
