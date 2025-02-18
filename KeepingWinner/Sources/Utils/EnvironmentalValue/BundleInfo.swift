//
//  BundleInfo.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum BundleInfo {
  static var getVersion: String? {
    return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
}
