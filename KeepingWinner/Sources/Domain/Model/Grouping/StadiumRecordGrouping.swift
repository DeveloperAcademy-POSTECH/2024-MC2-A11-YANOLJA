//
//  StadiumRecordGrouping.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/15/25.
//

import Foundation

struct StadiumRecordGrouping: RecordGrouping {
  let title: String = "구장별"
  let stadiums: [StadiumModel]
  let myRecords: [RecordModel]
  
  func categories(validYear: String) -> [String] {
    let yearStadiums = self.stadiums
      .filter {
        let recentYear = Int(Date.now.year) ?? KeepingWinningRule.dataUpdateYear
        let filteredYear = Int(validYear) ?? recentYear
        return $0.isValid(in: filteredYear)
      }
    
    if validYear != "전체" {
      return yearStadiums.map { $0.name(year: validYear) }
    } else {
      let extraStadium = self.myRecords.filter { !yearStadiums.map { $0.symbol }.contains( $0.stadium.symbol) }
      return (yearStadiums.map { $0.name(year: validYear) } + extraStadium.map { $0.stadium.name(year: $0.date.year) })
    }
  }
  
  // 경기 날짜를 기준으로 요일 구분 필터 함수
  func matchesCategory(record: RecordModel, category: String) -> Bool {
    guard let categoryIndex = stadiums.indices.filter({ stadiums[$0].contains(fullName: category) }).first else { return false }
    
    let categoryStadium = stadiums[categoryIndex]
    return record.stadium.symbol == categoryStadium.symbol
  }
  
  func sortPriority(_ lhs: String, _ rhs: String) -> Bool {
    lhs.sortKRPriority(rhs)
  }
}
