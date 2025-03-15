//
//  HomeAwayRecordGrouping.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/15/25.
//

import Foundation

struct HomeAwayRecordGrouping: RecordGrouping {
  let title: String = "홈/원정별"
  let myTeam: BaseballTeamModel
  let stadiums: [StadiumModel]
  
  func categories(validYear: String) -> [String] {
    return ["홈", "원정"]
  }
  
  // 경기 날짜를 기준으로 요일 구분 필터 함수
  func matchesCategory(record: RecordModel, category: String) -> Bool {
    let myTeamHomes = myTeam.allStadiums()
    let myTeamHomeSymbols = myTeamHomes.map { $0.symbol }
    let isHomeRecord = myTeamHomeSymbols.contains(record.stadium.symbol)
    return category == "홈" ? isHomeRecord : !isHomeRecord
  }
}
