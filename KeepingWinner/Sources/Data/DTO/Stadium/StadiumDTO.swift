//
//  StadiumDTO.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/13/25.
//

import Foundation

struct StadiumDTO: CheckValidYear {
  let id: UUID
  let symbol: String
  let histories: [StadiumNameHistoryDTO]
  let startYear: Int
  let dueYear: Int?
  
  init(
    id: UUID = .init(),
    symbol: String,
    histories: [StadiumNameHistoryDTO] = [],
    startYear: Int = 0,
    dueYear: Int? = nil
  ) {
    self.id = id
    self.symbol = symbol
    self.histories = histories
    self.startYear = startYear
    self.dueYear = dueYear
  }
}

struct StadiumNameHistoryDTO {
  let name: String
  let startYear: Int
  let dueYear: Int?
}

extension StadiumDTO {
  var convert: StadiumModel {
    return StadiumModel.init(
      symbol: self.symbol,
      histories: self.histories.convert,
      startYear: self.startYear,
      dueYear: self.dueYear
    )
  }
}

extension Array<StadiumDTO> {
  var convert: [StadiumModel] {
    return self.map { dto in dto.convert }
  }
}

extension Array<StadiumNameHistoryDTO> {
  var convert: [StadiumNameHistory] {
    
    return self.map { dto in
      StadiumNameHistory.init(
        name: dto.name,
        startYear: dto.startYear,
        dueYear: dto.dueYear
      )
    }
  }
}
