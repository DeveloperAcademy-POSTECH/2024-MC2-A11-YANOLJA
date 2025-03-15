//
//  RecordModel.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI
import UIKit

struct RecordModel: Identifiable {
  var id: UUID
  var date: Date
  var stadium: StadiumModel
  var isDoubleHeader: Int // 추가
  var myTeam: BaseballTeamModel
  var vsTeam: BaseballTeamModel
  var myTeamScore: String // 추가
  var vsTeamScore: String // 추가
  var isCancel: Bool // 추가
  var memo: String? // 추가
  var photo: UIImage?
  
  
  init(
    id: UUID = .init(),
    date: Date = .now,
    stadium: StadiumModel,
    isDoubleHeader: Int = -1, // (-1, 0, 1)
    myTeam: BaseballTeamModel,
    vsTeam: BaseballTeamModel,
    myTeamScore: String = "0",
    vsTeamScore: String = "0",
    isCancel: Bool = false,
    memo: String? = nil,
    photo: UIImage? = nil
  ) {
    self.id = id
    self.date = date
    self.stadium = stadium
    self.isDoubleHeader = isDoubleHeader
    self.myTeam = myTeam
    self.vsTeam = vsTeam
    self.myTeamScore = myTeamScore
    self.vsTeamScore = vsTeamScore
    self.isCancel = isCancel
    self.memo = memo
    self.photo = photo
  }
  
  var result: GameResult { // 계산 속성으로 변경
    guard !self.isCancel else { return .cancel }
    let myTeamScore = Int(myTeamScore) ?? 0
    let vsTeamScore = Int(vsTeamScore) ?? 0
    if myTeamScore > vsTeamScore {
      return .win
    } else if myTeamScore < vsTeamScore {
      return .lose
    } else {
      return .draw
    }
  }
}
