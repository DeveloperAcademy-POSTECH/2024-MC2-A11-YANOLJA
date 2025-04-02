//
//  WeekdayRecordGrouping.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/15/25.
//

import Foundation

struct WeekdayRecordGrouping: RecordGrouping {
  let title: String = "요일별"
  func categories(validYear: String) -> [String] {
    return ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
  }
  
  // 경기 날짜를 기준으로 요일 구분 필터 함수
  func matchesCategory(record: RecordModel, category: String) -> Bool {
    // date에서 요일 숫자 가져오기 (1: 일요일 ~ 7: 토요일)
    let calendar = Calendar.current
    let weekdayIndex = calendar.component(.weekday, from: record.date) - 1
    let adjustedIndex = (weekdayIndex + 6) % 7 // 0: 월요일 ~ 6: 일요일
    
    return self.categories(validYear: "")[adjustedIndex] == category
  }
  
  func sortPriority(_ lhs: String, _ rhs: String) -> Bool {
    let categoreis = self.categories(validYear: "")
    let lhsIndex = categoreis.firstIndex(of: lhs) ?? .zero
    let rhsIndex = categoreis.firstIndex(of: rhs) ?? .zero
    return lhsIndex < rhsIndex
  }
}
