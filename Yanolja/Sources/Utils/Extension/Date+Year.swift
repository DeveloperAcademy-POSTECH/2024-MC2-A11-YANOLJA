//
//  Date+Year.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension Date {
  var year: String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY"
    return dateFormatter.string(from: self)
  }
}
