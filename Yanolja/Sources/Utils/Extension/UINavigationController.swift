//
//  UINavigationController.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  override public func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isPopGestureEnabled.rawValue) && viewControllers.count > 1
  }
}
