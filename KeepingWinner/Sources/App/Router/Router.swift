//
//  Router.swift
//  Yanolja
//
//  Created by 박혜운 on 2/5/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import SwiftUI

final class Router: ObservableObject {
  @Published var path = NavigationPath()
  
  enum NavigationDestination: Hashable {
    case settings
    case analyticsDetail
  }
  
  func navigate(to destination: NavigationDestination) {
    path.append(destination)
  }
  
  func navigateBack() {
    path.removeLast()
  }
  
  func navigateToRoot() {
    path.removeLast(path.count)
  }
}

