//
//  RecordFilter.swift
//  Yanolja
//
//  Created by 박혜운 on 10/2/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum RecordFilter: CaseIterable, Hashable {
  static let allCases: [RecordFilter] = [.all, teamOptions(.doosan), stadiumsOptions(BaseballStadiums.nameList.first ?? ""), .resultsOptions(.win)]
  static let initialValue: Self = .all
  
  case all
  case teamOptions(BaseballTeam)
  case stadiumsOptions(String)
  case resultsOptions(GameResult)
  
  var label: String {
    switch self {
    case .all:
      return "전체"
    case .teamOptions:
      return "구단별"
    case .stadiumsOptions:
      return "구장별"
    case .resultsOptions:
      return "결과별"
    }
  }
}
