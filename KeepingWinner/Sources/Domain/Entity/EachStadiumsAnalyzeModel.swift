//
//  EachStadiumsAnalyticsModel.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

struct EachStadiumsAnalyticsModel: Identifiable {
  let id: UUID = .init()
  var stadiumsWinRate: [String: Int?] = [:]
  var stadiumsRecordCount: [String: Int?] = [:]
  
  func sortByWinRate(ascending: Bool) -> [String] {
    return BaseballStadiums.nameList
      .sorted {
        let leftWinRate = stadiumsWinRate[$0] ?? nil
        let rightWinRate = stadiumsWinRate[$1] ?? nil
        let leftGameCount = stadiumsRecordCount[$0] ?? nil
        let rightGameCount = stadiumsRecordCount[$1] ?? nil
        
        if let leftWinRate, let rightWinRate {
          return ascending ? leftWinRate >= rightWinRate : leftWinRate < rightWinRate
        } else if leftWinRate != nil {
          return ascending ? true : false
        } else if rightWinRate != nil {
          return ascending ? false : true
        }else if let leftGameCount, let rightGameCount {
          return ascending ? leftGameCount >= rightGameCount : leftGameCount < rightGameCount
        } else if leftGameCount != nil {
          return ascending ? true : false
        } else if rightGameCount != nil {
          return ascending ? false : true
        } else {
          return ascending ? $0 < $1 : $0 > $1
        }
      }
  }
}
