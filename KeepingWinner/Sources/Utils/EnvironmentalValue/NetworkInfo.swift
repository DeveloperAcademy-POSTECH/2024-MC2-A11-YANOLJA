//
//  NetworkInfo.swift
//  KeepingWinner
//
//  Created by 박혜운 on 2/12/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation

enum NetworkInfo {
  static var getURL: String? {
    return Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String
  }
}
