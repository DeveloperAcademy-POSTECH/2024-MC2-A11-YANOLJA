//
//  RecordGrouping.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/15/25.
//

import Foundation

protocol RecordGrouping {
  var title: String { get } // 예: "요일별", "구장별", "상대팀별"
  func categories(validYear: String) -> [String] // 예: ["월요일", "화요일", ..., "일요일"]
  func matchesCategory(record: RecordModel, category: String) -> Bool // 특정 카테고리에 속하는지 판별
  func sortPriority(_ lhs: String, _ rhs: String) -> Bool
}
