//
//  Date+GameDate.swift
//  Yanolja
//
//  Created by 유지수 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

extension Date {
  // 날짜를 주어진 형식으로 문자열로 변환하는 함수
  func gameDate(with format: String = "yyyy.MM.dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
}
