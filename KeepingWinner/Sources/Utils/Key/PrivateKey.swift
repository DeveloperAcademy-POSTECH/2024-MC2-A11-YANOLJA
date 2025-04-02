//
//  PrivateKey.swift
//  Yanolja
//
//  Created by 박혜운 on 1/13/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation

enum PrivateKey {
  static var getMixpanel: String? {
    return Bundle.main.object(forInfoDictionaryKey: "MixpanelKEY") as? String
  }
  
  static var getInstgram: String? {
    return Bundle.main.object(forInfoDictionaryKey: "InstagramID") as? String
  }
}
