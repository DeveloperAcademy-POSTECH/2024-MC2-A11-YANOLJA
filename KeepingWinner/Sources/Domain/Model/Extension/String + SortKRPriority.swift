//
//  Array<String> + KRSort.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/23/25.
//

import Foundation

extension String {
  func sortKRPriority(_ to: String) -> Bool {
    self.compare(to, locale: Locale(identifier: "ko_KR")) == .orderedAscending
  }
}
