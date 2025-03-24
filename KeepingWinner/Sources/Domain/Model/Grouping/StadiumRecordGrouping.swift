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
  
  func categories(validYear: String) -> [String] {
    self.stadiums
      .filter {
        let recentYear = Int(Date.now.year) ?? KeepingWinningRule.dataUpdateYear
        let filteredYear = Int(validYear) ?? recentYear
        return $0.isValid(in: filteredYear)
      }
      .map { $0.name(year: validYear) }
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
