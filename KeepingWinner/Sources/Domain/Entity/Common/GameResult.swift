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
  case cancel
  
  var title: String {
    switch self {
    case .win:
      return "승"
    case .lose:
      return "패"
    case .draw:
      return "무"
    case .cancel:
      return "취소"
    }
  }
  
  var label: String {
    switch self {
    case .win:
      return "승리"
    case .lose:
      return "패배"
    case .draw:
      return "무승부"
    case .cancel:
      return "취소"
    }
  }
}
