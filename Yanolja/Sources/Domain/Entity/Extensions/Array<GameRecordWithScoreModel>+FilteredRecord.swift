//
//  Array<GameRecordWithScoreModel>+Filtered.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension Array<GameRecordWithScoreModel> {
  func filtered(options: RecordFilter) -> Self {
    switch options {
    case .all:
      return self
    case .teamOptions(let baseballTeam):
      return self.filter { $0.vsTeam == baseballTeam }
    case .stadiumsOptions(let stadiums):
      return self.filter { $0.stadiums == stadiums }
    case .resultsOptions(let gameResult):
      return self.filter { $0.result == gameResult }
    }
  }
}
