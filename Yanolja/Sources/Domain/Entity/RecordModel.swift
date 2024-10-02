//
//  RecordModel.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - v1.0 이전 Record 데이터
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

// MARK: - v1.0 이후 Record 데이터
struct GameRecordWithScoreModel: Identifiable {
  init(
    id: UUID = .init(),
    date: Date = .init(),
    stadiums: String = BaseballStadiums.nameList.first ?? "고척스카이돔",
    myTeam: BaseballTeam = .doosan,
    vsTeam: BaseballTeam = .doosan.anyOtherTeam(),
    isDoubleHeader: Int = 0,
    myTeamScore: String = "-",
    vsTeamScore: String = "-",
    isCancel: Bool = false,
    memo: String? = nil,
    photo: Image? = nil
  ) {
    self.id = id
    self.date = date
    self.stadiums = stadiums
    self.isDoubleHeader = isDoubleHeader
    self.myTeam = myTeam
    self.vsTeam = vsTeam
    self.myTeamScore = myTeamScore
    self.vsTeamScore = vsTeamScore
    self.isCancel = isCancel
    self.memo = memo
    self.photo = photo
  }
  
  let id: UUID
  var date: Date
  var stadiums: String
  var isDoubleHeader: Int // 추가
  var myTeam: BaseballTeam
  var vsTeam: BaseballTeam
  var myTeamScore: String // 추가
  var vsTeamScore: String // 추가
  var isCancel: Bool // 추가
  var memo: String? // 추가
  var photo: Image? // 추가
  
  var result: GameResult { // 계산 속성으로 변경
    guard let myTeamScore = Int(myTeamScore), let vsTeamScore = Int(vsTeamScore) else { return .draw }
    if myTeamScore > vsTeamScore {
      return .win
    } else if myTeamScore < vsTeamScore {
      return .lose
    } else {
      return .draw
    }
  }
}
