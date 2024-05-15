//
//  WinRateUseCase.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

@Observable
class WinRateUseCase {
  struct State {
    var tappedTeamWinRateCell: Bool = false
    var myTeam: BaseballTeam = .myTeam // 초기 값
    var myWinRate: MyWinRateEntity = .init()
  }
  
  enum Action {
    case requestTeamChange(BaseballTeam)
    case tappedTeamWinRateCell
  }
  
  private var _state: State = .init()
  var state: State {
    _state
  }
  
  func effect(_ action: Action) {
    switch action {
    case .requestTeamChange(let team):
      BaseballTeam.myTeam = team
      _state.myTeam = team
      
    case .tappedTeamWinRateCell:
      _state.tappedTeamWinRateCell.toggle()
    }
  }
}
