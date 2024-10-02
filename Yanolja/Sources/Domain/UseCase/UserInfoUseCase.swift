//
//  userInfoUseCase.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

@Observable
class UserInfoUseCase {
  struct State {
    var myTeam: BaseballTeam?
    var myNickname: String = "기본 이름"
  }
  
  enum Action {
    case changeMyTeam(BaseballTeam)
    case changeMyNickname(String)
  }
  
  private var myTeamService: MyTeamServiceInterface
  private var myNicknameService: MyNicknameServiceInterface
  private var changeAppIconService: ChangeAppIconInterface
  private var _state: State = .init() // 원본 State, Usecase 내부에서만 접근가능
  var state: State { _state } // View에서 접근하는 state
  
  init(
    myTeamService: MyTeamServiceInterface,
    myNicknameService: MyNicknameServiceInterface,
    changeIconService: ChangeAppIconInterface
  ) {
    self.changeAppIconService = changeIconService
    self.myTeamService = myTeamService
    self.myNicknameService = myNicknameService
    _state.myNickname = myNicknameService.readMyNickname() ?? "기본 이름"
    _state.myTeam = myTeamService.readMyTeam()
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case let .changeMyTeam(newTeam):
      myTeamService.saveTeam(to: newTeam)
      changeAppIconService.requestChangeAppIcon(to: newTeam)
      _state.myTeam = newTeam
      
    case let .changeMyNickname(newName):
      myNicknameService.saveNickname(to: newName)
      _state.myNickname = newName
    }
  }
}
