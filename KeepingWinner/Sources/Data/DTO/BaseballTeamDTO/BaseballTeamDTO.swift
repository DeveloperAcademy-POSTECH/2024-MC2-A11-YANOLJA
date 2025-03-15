//
//  BaseballTeamDTO.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/14/25.
//

import Foundation

struct BaseballTeamDTO {
  let symbol: String
  let teamHistories: [BaseballHistoryDTO]
  let homeHistories: [HomeStadiumHistoryDTO]
  
  init(
    symbol: String = "",
    teamHistories: [BaseballHistoryDTO] = [],
    homeHistories: [HomeStadiumHistoryDTO] = []
  ) {
    self.symbol = symbol
    self.teamHistories = teamHistories
    self.homeHistories = homeHistories
  }
}

struct BaseballHistoryDTO {
  let name: String
  let colorHex: String
  let subColorHex: String
  let startYear: Int
  let dueYear: Int?
  
  init(name: String, colorHex: String, subColorHex: String, startYear: Int, dueYear: Int? = nil) {
    self.name = name
    self.colorHex = colorHex
    self.subColorHex = subColorHex
    self.startYear = startYear
    self.dueYear = dueYear
  }
}

extension BaseballHistoryDTO {
  var convert: BaseballHistory {
    return .init(
      name: self.name,
      colorHex: self.colorHex,
      subColorHex: self.subColorHex,
      startYear: self.startYear,
      dueYear: self.dueYear
    )
  }
}

extension Array<BaseballHistoryDTO> {
  var convert: [BaseballHistory] {
    return self.map { dto in dto.convert }
  }
}

extension BaseballTeamDTO {
  var convert: BaseballTeamModel {
    return .init(
      symbol: self.symbol,
      teamHistories: self.teamHistories.convert,
      homeHistories: self.homeHistories.convert
    )
  }
}
