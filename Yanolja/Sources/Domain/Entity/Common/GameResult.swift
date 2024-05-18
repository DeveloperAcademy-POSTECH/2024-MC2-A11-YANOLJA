//
//  GameResultType.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

enum GameResult: String, CaseIterable {
  case win
  case lose
  case draw
  
  var title: String {
    switch self {
    case .win:
      return "승"
    case .lose:
      return "패"
    case .draw:
      return "무"
    }
  }
}
