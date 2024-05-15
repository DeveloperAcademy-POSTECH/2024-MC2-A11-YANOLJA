//
//  MatchRecordEntity.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

struct MatchRecordEntity: Identifiable {
  init(
    date: Date = .init(),
    myTeam: BaseballTeam = .myTeam,
    matchTeam: BaseballTeam = .otherTeams.first ?? .myTeam,
    stadiums: BaseballStadiums = .jamsil,
    result: GameResult = .win
  ) {
    self.date = date
    self.myTeam = myTeam
    self.matchTeam = matchTeam
    self.stadiums = stadiums
    self.result = result
  }
  
  let id: UUID = .init()
  var date: Date
  var myTeam: BaseballTeam
  var matchTeam: BaseballTeam
  var stadiums: BaseballStadiums
  var result: GameResult
}
