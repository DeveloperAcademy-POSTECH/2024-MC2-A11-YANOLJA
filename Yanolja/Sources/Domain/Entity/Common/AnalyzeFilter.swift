//
//  AnalyticsFilter.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum AnalyticsFilter: Hashable {
  static var allCases: [AnalyticsFilter] = [.team(.doosan), .stadiums(BaseballStadiums.nameList.first ?? "")]
  
  static let initialValue: Self = .team(.doosan)
  
  case team(BaseballTeam)
  case stadiums(String)
  
  var label: String {
    switch self {
    case .team:
      return "상대구단별"
    case .stadiums:
      return "구장별"
    }
  }
  
  var selectedTitle: String {
    switch self {
    case let .team(title):
      return title.name
    case let .stadiums(title):
      return title
    }
  }
}
