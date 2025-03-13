//
//  BaseballTeamDTO.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

struct BaseballTeamModel {
  private let id: UUID
  var symbol: String
  private let teamHistories: [BaseballHistory]
  private let homeHistories: [HomeStadiumHistory]
  
  init(
    id: UUID = .init(),
    symbol: String,
    teamHistories: [BaseballHistory],
    homeHistories: [HomeStadiumHistory]
  ) {
    self.id = id
    self.symbol = symbol
    self.teamHistories = teamHistories
    self.homeHistories = homeHistories
  }

  func name(year: Int) -> String {
    return self.teamHistories.filter { $0.isValid(in: year) }.first?.name ?? ""
  }
}

extension BaseballTeamModel {
  static let dummy = Self.init(symbol: "doosan", teamHistories: [], homeHistories: [])
}

extension Array<BaseballTeamModel> {
  func find(symbol: String) -> BaseballTeamModel? {
    return self.filter { $0.symbol == symbol }.first
  }
}

struct BaseballHistory: CheckValidYear {
  let name: String // 키움 히어로즈
  let colorHex: String // 000000
  let startYear: Int // 2015
  let dueYear: Int?
}

struct HomeStadiumHistory {
  let stadium: StadiumModel
  let startYear: Int
  let dueYear: Int?
}
