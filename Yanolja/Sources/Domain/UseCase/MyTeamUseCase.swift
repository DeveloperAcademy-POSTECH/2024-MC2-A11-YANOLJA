//
//  MyTeamUseCase.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

@Observable
class MyTeamUseCase {
  struct State {
    var myTeam: BaseballTeam?
  }
  
  enum Action {
    case changeMyTeam(BaseballTeam)
  }
  
  private var myTeamService: MyTeamServiceInterface
  private var changeAppIconService: ChangeAppIconInterface
  private var _state: State = .init() // 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    _state
  }
  
  init(
    myTeamService: MyTeamServiceInterface,
    changeIconService: ChangeAppIconInterface
  ) {
    self.changeAppIconService = changeIconService
    self.myTeamService = myTeamService
    _state.myTeam = myTeamService.readMyTeam()
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case let .changeMyTeam(newTeam):
      myTeamService.saveTeam(to: newTeam)
      changeAppIconService.requestChangeAppIcon(to: newTeam)
      _state.myTeam = newTeam
    }
  }
}
