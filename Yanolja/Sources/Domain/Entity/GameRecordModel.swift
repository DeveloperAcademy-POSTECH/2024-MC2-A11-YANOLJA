//
//  GameRecordEntity.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

struct GameRecordModel: Identifiable {
  init(
    date: Date = .init(),
    myTeam: BaseballTeam = .myTeam,
    vsTeam: BaseballTeam = .otherTeams.first ?? .myTeam,
    stadiums: BaseballStadiums = .jamsil,
    gameResult: GameResult = .win
  ) {
    self.date = date
    self.myTeam = myTeam
    self.vsTeam = vsTeam
    self.stadiums = stadiums
    self.result = gameResult
  }
  
  let id: UUID = .init()
  var date: Date
  var myTeam: BaseballTeam
  var vsTeam: BaseballTeam
  var stadiums: BaseballStadiums
  var result: GameResult
}
