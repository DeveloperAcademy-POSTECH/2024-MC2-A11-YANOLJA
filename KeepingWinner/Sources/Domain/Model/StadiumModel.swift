//
//  StadiumModel.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

struct StadiumModel: Hashable, CheckValidYear {
  let id: UUID
  let symbol: String
  let histories: [StadiumNameHistory]
  let startYear: Int
  let dueYear: Int?
  
  init(
    id: UUID = .init(),
    symbol: String,
    histories: [StadiumNameHistory],
    startYear: Int,
    dueYear: Int?
  ) {
    self.id = id
    self.symbol = symbol
    self.histories = histories
    self.startYear = startYear
    self.dueYear = dueYear
  }
  
  func name(
    year: String = String(KeepingWinningRule.dataUpdateYear)
  ) -> String {
    let recentYear = Int(Date.now.year) ?? KeepingWinningRule.dataUpdateYear
    let year = Int(year) ?? recentYear
    let name = self.histories.filter {
      $0.isValid(in: year)
    }.first?.name ?? ""
    
    return name
  }
  
  func contains(fullName: String) -> Bool {
    return self.histories.map { $0.name }.contains(fullName)
  }
}

extension StadiumModel {
  static let dummy = Self.init(symbol: "고척스카이돔", histories: [], startYear: 0, dueYear: nil)
}

extension Array<StadiumModel> {
  func find(symbol: String) -> StadiumModel? {
    return self.filter { $0.symbol == symbol }.first
  }
}

struct StadiumNameHistory: Hashable, CheckValidYear {
  let name: String
  let startYear: Int
  let dueYear: Int?
}
