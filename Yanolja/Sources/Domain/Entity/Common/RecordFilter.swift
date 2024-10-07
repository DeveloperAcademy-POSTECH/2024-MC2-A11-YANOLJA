//
//  RecordFilter.swift
//  Yanolja
//
//  Created by 박혜운 on 10/2/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum RecordFilter: CaseIterable, Hashable {
  static var allCases: [RecordFilter] = [.all, team(.doosan), stadiums(BaseballStadiums.nameList.first ?? ""), .results(.win)]
  
//  static let list: [String] = ["전체", "구단별", "구장별", "승리", "패배", "무승부", "취소"]
  static let initialValue: Self = .all
  case all
  case team(BaseballTeam)
  case stadiums(String)
  case results(GameResult)
  
  var label: String {
    switch self {
    case .all:
      return "전체"
    case .team:
      return "구단별"
    case .stadiums:
      return "구장별"
    case .results:
      return "결과별"
    }
  }
}
