//
//  YearFilter.swift
//  Yanolja
//
//  Created by 박혜운 on 10/2/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum YearFilter {
  static let list: [String] = ["전체"] + (KeepingWinningRule.dataLimitYear...KeepingWinningRule.dataUpdateYear).reversed()
    .map { String($0) }
  static let initialValue: String = list.first ?? "전체"
}
