//
//  Array<RecordModel> + Filtered.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

extension Array<RecordModel> {
  func filtered(year: String) -> Self {
    if year == "전체" {
      return self
    } else {
      return self.filter { $0.date.year == year }
    }
  }
}
