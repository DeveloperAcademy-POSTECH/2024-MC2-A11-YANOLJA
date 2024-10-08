//
//  Array<GameRecordWithScoreModel>+FilteredYear.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension Array<GameRecordWithScoreModel> {
  func filtered(years: String) -> Self {
    switch years {
    case "2023": fallthrough
    case "2024":
      return self.filter { $0.date.year == years }
    default: return self
    }
  }
}
