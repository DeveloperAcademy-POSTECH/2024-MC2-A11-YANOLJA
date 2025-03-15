//
//  Array<RecordModel> + sortByLatestDate.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

extension Array<RecordModel> {
  func sortByLatestDate(_ byLatest: Bool) -> Self {
    if byLatest {
      return self.sorted { $0.date > $1.date }
    } else {
      return self.sorted { $0.date <= $1.date }
    }
  }
}
