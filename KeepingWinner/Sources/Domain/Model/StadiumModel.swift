//
//  StadiumModel.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

// (1) 똑같이 이름으로 저장한다. 근데, 읽을 때 StadiumModel로 바꾼다 "신구장" 업데이
// 이름이라서 문제임
// (2) 지금부터 '심볼'로 저장한다 (String), 읽을 때 변환 코드 필요 왜냐? 현재 심볼로 저장되어 있지 않은 유저가 존재하기 때문

struct StadiumModel: CheckValidYear {
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
}

extension StadiumModel {
  static let dummy = Self.init(symbol: "", histories: [], startYear: 0, dueYear: nil)
}

extension Array<StadiumModel> {
  func find(symbol: String) -> StadiumModel? {
    return self.filter { $0.symbol == symbol }.first
  }
}

struct StadiumNameHistory {
  let name: String
  let startYear: Int
  let dueYear: Int?
}
