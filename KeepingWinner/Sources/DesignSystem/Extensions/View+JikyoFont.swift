//
//  Font+JikyoFont.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

public enum JikyoFontType {
  // MARK: - 숫자 전용 폰트타입
  case mainWinRate
  case mainWinRatePercentage
  case recordCell
  case recordCellInner
}

extension View {
  func jikyoFont(_ fontStyle: JikyoFontType) -> some View {
    switch fontStyle {
    case .mainWinRate:
      return self
        .font(Font.custom("SquadaOne-Regular", size: 260))
        .kerning(-9)
        
    case .mainWinRatePercentage:
      return self
        .font(Font.custom("SquadaOne-Regular", size: 50))
        .kerning(0)
    case .recordCell:
      return self
        .font(Font.custom("SquadaOne-Regular", size: 75))
        .kerning(0)
    case .recordCellInner:
      return self
        .font(Font.custom("SquadaOne-Regular", size: 50))
        .kerning(0)
    }
  }
}
      
