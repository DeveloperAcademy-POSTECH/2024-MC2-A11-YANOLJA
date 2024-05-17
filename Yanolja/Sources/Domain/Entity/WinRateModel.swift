//
//  WinRateEntity.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation
import SwiftUI

struct WinRateModel: Identifiable {
  let id: UUID = .init()
  var totalWinRate: Int?
  var totalRecordCount: Int = 0
  var vsTeamWinRate: [BaseballTeam: Int] = [:]
  var vsTeamRecordCount: [BaseballTeam: Int] = [:]
}
