//
//  WinRateEntity.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

struct EachTeamAnalyticsModel: Identifiable {
  let id: UUID = .init()
  var vsTeamWinRate: [BaseballTeam: Int?] = [:]
  var vsTeamRecordCount: [BaseballTeam: Int?] = [:]

  func sortByWinRate(ascending: Bool) -> [BaseballTeam] {
    return BaseballTeam
      .recordBaseBallTeam
      .sorted {
        let leftWinRate = vsTeamWinRate[$0] ?? nil
        let rightWinRate = vsTeamWinRate[$1] ?? nil
        let leftGameCount = vsTeamRecordCount[$0] ?? nil
        let rightGameCount = vsTeamRecordCount[$1] ?? nil
        
        if let leftWinRate, let rightWinRate {
          return ascending ? leftWinRate >= rightWinRate : leftWinRate < rightWinRate
        } else if leftWinRate != nil {
          return ascending ? true : false
        } else if rightWinRate != nil {
          return ascending ? false : true
        } else if let leftGameCount, let rightGameCount {
          return ascending ? leftGameCount >= rightGameCount : leftGameCount < rightGameCount
        } else if leftGameCount != nil {
          return ascending ? true : false
        } else if rightGameCount != nil {
          return ascending ? false : true
        } else {
          return ascending ? $0.name < $1.name : $0.name > $1.name
        }
      }
  }
}
