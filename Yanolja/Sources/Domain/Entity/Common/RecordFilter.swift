//
//  RecordFilter.swift
//  Yanolja
//
//  Created by 박혜운 on 10/2/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum RecordFilter {
  static let list: [String] = ["전체", "구단별", "구장별", "승리", "패배", "무승부", "취소"]
  static let initialValue: String = list.first ?? "전체"
}
