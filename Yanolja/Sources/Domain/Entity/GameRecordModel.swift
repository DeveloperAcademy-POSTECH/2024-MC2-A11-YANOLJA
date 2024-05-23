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
    id: UUID = .init(),
    date: Date = .init(),
    myTeam: BaseballTeam = .doosan,
    vsTeam: BaseballTeam = .doosan.anyOtherTeam(),
    stadiums: BaseballStadiums = .jamsil,
    gameResult: GameResult = .win
    
  ) {
    self.id = id
    self.date = date
    self.myTeam = myTeam
    self.vsTeam = vsTeam
    self.stadiums = stadiums
    self.result = gameResult
  }
  
  let id: UUID
  var date: Date
  var myTeam: BaseballTeam
  var vsTeam: BaseballTeam
  var stadiums: BaseballStadiums
  var result: GameResult
}
