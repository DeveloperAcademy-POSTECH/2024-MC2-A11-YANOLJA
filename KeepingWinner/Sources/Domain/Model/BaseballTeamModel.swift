//
//  BaseballTeamDTO.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import SwiftUI

enum BaseballTeamName {
  case company
  case name
  case full
}

struct BaseballTeamModel: Hashable {
  static func == (lhs: BaseballTeamModel, rhs: BaseballTeamModel) -> Bool {
    return lhs.symbol == rhs.symbol
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(symbol)
  }
  
  static let noTeam: BaseballTeamModel = KeepingWinningRule.noTeamBaseballModel
  
  let id: UUID
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
  
  var isNoTeam: Bool {
    return self.symbol == KeepingWinningRule.noTeamSymbol
  }
  
  func name(
    year: String = String(KeepingWinningRule.dataUpdateYear),
    type: BaseballTeamName = .company
  ) -> String {
    let recentYear = KeepingWinningRule.dataUpdateYear
    let year = Int(year) ?? recentYear
    let fullName = self.teamHistories.filter {
      $0.isValid(in: year)
    }.first?.name ?? KeepingWinningRule.noTeamName
    
    return nameSlice(
      fullName: fullName,
      type: type
    ) ?? KeepingWinningRule.noTeamName
  }
  
  func contains(fullName: String) -> Bool {
    return self.teamHistories.map { $0.name }.contains(fullName)
  }
  
  func colorHex(
    year: String = String(KeepingWinningRule.dataUpdateYear),
    type: BaseballTeamName = .company
  ) -> String {
    let recentYear = KeepingWinningRule.dataUpdateYear
    let year = Int(year) ?? recentYear
    let colorHex = self.teamHistories.filter {
      $0.isValid(in: year)
    }.first?.colorHex
    
    return colorHex ?? KeepingWinningRule.noTeamColorHex
  }
  
  func homeStadium(year: String) -> StadiumModel? {
    return homeStadiums(year: year).first
  }
  
  func homeStadiums(year: String) -> [StadiumModel] {
    let year = Int(year) ?? KeepingWinningRule.dataUpdateYear
    return self.homeHistories.map { $0.stadium }.filter { $0.isValid(in: year) }
  }
  
  func allStadiums() -> [StadiumModel] {
    return self.homeHistories.map { $0.stadium }
  }
  
  private func nameSlice(fullName: String, type: BaseballTeamName = .company) -> String? {
    let fullNameList = fullName.components(separatedBy: " ")
    if case type = .company {
      return fullNameList.first
    } else if case type = .name {
      return fullNameList.last
    } else {
      return fullName
    }
  }
}

extension BaseballTeamModel {
  func color(
    year: String = String(KeepingWinningRule.dataUpdateYear),
    type: BaseballTeamName = .company
  ) -> Color {
    let recentYear = KeepingWinningRule.dataUpdateYear
    let year = Int(year) ?? recentYear
    let colorHex = self.teamHistories.filter {
      $0.isValid(in: year)
    }.first?.colorHex ?? KeepingWinningRule.noTeamColorHex
    
    return Color(hexString: colorHex)
  }
  
  func subColor(
    year: String = String(KeepingWinningRule.dataUpdateYear),
    type: BaseballTeamName = .company
  ) -> Color {
    let recentYear = KeepingWinningRule.dataUpdateYear
    let year = Int(year) ?? recentYear
    let colorHex = self.teamHistories.filter {
      $0.isValid(in: year)
    }.first?.subColorHex ?? KeepingWinningRule.noTeamColorHex
    
    return Color(hexString: colorHex)
  }
}

extension BaseballTeamModel {
  static let dummy = Self.init(symbol: "doosan", teamHistories: [], homeHistories: [])
  static let dummyOther = Self.init(symbol: "kiwoom", teamHistories: [], homeHistories: [])
}

extension Array<BaseballTeamModel> {
  func find(symbol: String) -> BaseballTeamModel? {
    return self.filter { $0.symbol == symbol }.first
  }
  
  func first(without symbol: String) -> BaseballTeamModel? {
    self.filter { $0.symbol != symbol }.first
  }
}

struct BaseballHistory: CheckValidYear {
  let name: String // 키움 히어로즈
  let colorHex: String // 000000
  let subColorHex: String
  let startYear: Int // 2015
  let dueYear: Int?
}

struct HomeStadiumHistory {
  let stadium: StadiumModel
  let startYear: Int
  let dueYear: Int?
}
