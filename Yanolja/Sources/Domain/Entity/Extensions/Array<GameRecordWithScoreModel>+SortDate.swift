//
//  Array<GameRecordWithScoreModel>+Sort.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension Array<GameRecordWithScoreModel> {
  func sortByLatestDate(_ byLatest: Bool) -> Self {
    if byLatest {
      return self.sorted { $0.date > $1.date }
    } else {
      return self.sorted { $0.date <= $1.date }
    }
  }
}
