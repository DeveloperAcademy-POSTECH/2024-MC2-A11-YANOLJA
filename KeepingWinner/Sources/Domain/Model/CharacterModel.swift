//
//  CharacterModel.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct CharacterModel {
  var symbol: String
  var colorHex: String
  var totalWinRate: Int?

  var emotionByWinRate: CharacterEmotionType {
    switch self.totalWinRate {
    case .none:
      return .none
    case .some(let num):
      switch num {
      case 0..<26:
        return .veryBad
      case 26..<51:
        return .bad
      case 51..<76:
        return .good
      default:
        return .excellent
      }
    }
  }
}

extension CharacterModel {
  var color: Color {
    return Color(hexString: self.colorHex)
  }
}
