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
  var totalWinRate: Int? = 88
  var totalRecordCount: Int = 7
  var vsTeamWinRate: [BaseballTeam: Int?] = [.hanhwa: 80, .kiwoom: 90] // 임의 값
  var vsTeamRecordCount: [BaseballTeam: Int?] = [.hanhwa: 2, .kiwoom: 5] // 임의 값

  // MainView의 MediumVsTeamCell의 순서를 정렬하는 계산 속성
  var sortedTeams: [BaseballTeam] {
    BaseballTeam.allCases.sorted {
      let winRate0 = vsTeamWinRate[$0] ?? nil
      let winRate1 = vsTeamWinRate[$1] ?? nil
      
      if let winRate0 = winRate0, let winRate1 = winRate1 {
        return winRate0 > winRate1
      } else if winRate0 != nil {
        return true
      } else if winRate1 != nil {
        return false
      } else {
        return $0.hashValue < $1.hashValue
      }
    }
  }
}
