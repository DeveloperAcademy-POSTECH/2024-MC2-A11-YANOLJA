//
//  LoadingViewModifier.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

extension View {
  func loadingIndicator(isLoading: Bool) -> some View {
    self.modifier(LoadingViewModifier(isLoading: isLoading))
  }
}

struct LoadingViewModifier: ViewModifier {
  let isLoading: Bool
  
  func body(content: Content) -> some View {
    content
      .overlay(
        Group {
          if isLoading {
            VStack(spacing: 23) {
              ActivityIndicator(isAnimating: .constant(true), style: .large)
              Text("불러오는 중...")
                .font(.callout)
                .foregroundColor(.black)
            }
            .frame(width: 155, height: 157)
            .background(.regularMaterial)
            .cornerRadius(8)
          }
        }
      )
  }
}

