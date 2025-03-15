//
//  KeepingWinningRule.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

enum KeepingWinningRule {
  static let dataLimitYear: Int = 2015
  static let dataUpdateYear: Int = 2025
  static let defaultBubbleTexts: [String] = ["오늘은 누구 응원할까?", "내가 혹시 승리요정??", "어느 구단으로 취직하지?", "이기는 팀 우리 팀?", "홈런 가자!?"]
  static let noTeamName: String = "무직"
  static let noTeamSymbol: String = "noTeam"
  static let noTeamColorHex: String = "8E8E93"
  static let noTeamSubColorHex: String = "EAEAEA"
  static let noTeamBaseballModel: BaseballTeamModel = .init(
    symbol: Self.noTeamSymbol,
    teamHistories: [.init(name: Self.noTeamName, colorHex: Self.noTeamColorHex, subColorHex: Self.noTeamSubColorHex, startYear: Self.dataLimitYear, dueYear: Self.dataUpdateYear)],
    homeHistories: []
  )
}
