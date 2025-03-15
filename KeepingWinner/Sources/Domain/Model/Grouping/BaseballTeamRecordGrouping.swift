//
//  BaseballTeamRecordGrouping.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/15/25.
//

import Foundation

struct BaseballTeamRecordGrouping: RecordGrouping {
  let title: String = "상대구단별"
  let baseballTeams: [BaseballTeamModel]
  let myTeam: BaseballTeamModel
  
  func categories(validYear: String) -> [String] {
    baseballTeams
      .filter { $0.symbol != myTeam.symbol }
      .map { $0.name(year: validYear, type: .full) }
  }
  
  func matchesCategory(record: RecordModel, category: String) -> Bool {
    guard let categoryIndex = baseballTeams.indices.filter({ baseballTeams[$0].contains(fullName: category) }).first else { return false }
    let categoryStadium = baseballTeams[categoryIndex]
    
    return record.vsTeam.symbol == categoryStadium.symbol
  }
}

