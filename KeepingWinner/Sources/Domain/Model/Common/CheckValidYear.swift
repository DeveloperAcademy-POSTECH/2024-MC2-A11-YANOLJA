//
//  CheckValidYear.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import Foundation

protocol CheckValidYear {
  var startYear: Int { get }
  var dueYear: Int? { get }
  
  func isValid(in year: Int) -> Bool
}

extension CheckValidYear {
  func isValid(in year: Int) -> Bool {
    guard let nowYear = Int(Date.now.year) else { return false }
    let startYear = self.startYear
    let dueYear = self.dueYear ?? nowYear
    return (startYear...dueYear).contains(year)
  }
}
