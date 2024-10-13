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
    var myNickname: String?
    var bubbleTextList: [String] = []
    var notices: [NoticeModel] = []
  }
  
  enum Action {
    case changeMyTeam(BaseballTeam)
    case changeMyNickname(String)
    case setNotices
    case setBubbleTexts
  }
  
  private var myTeamService: MyTeamServiceInterface
  private var myNicknameService: MyNicknameServiceInterface
  private var changeAppIconService: ChangeAppIconInterface
  private var settingsService: SettingsService
  private var _state: State = .init() // 원본 State, Usecase 내부에서만 접근가능
  var state: State { _state } // View에서 접근하는 state
  
  init(
    myTeamService: MyTeamServiceInterface,
    myNicknameService: MyNicknameServiceInterface,
    changeIconService: ChangeAppIconInterface,
    settingsService: SettingsService
  ) {
    self.changeAppIconService = changeIconService
    self.myTeamService = myTeamService
    self.myNicknameService = myNicknameService
    self.settingsService = settingsService
    _state.myNickname = myNicknameService.readMyNickname()
    _state.myTeam = myTeamService.readMyTeam()
    self.effect(.setNotices)
    self.effect(.setBubbleTexts)
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case .setNotices:
      Task {
        if case let .success(notices) = await settingsService.allNotices() {
          _state.notices = notices
        }
      }
      
    case .setBubbleTexts:
      Task {
        if case let .success(bubbleTextList) = await settingsService.characterBubbleTexts(_state.myTeam?.sliceName ?? "두산") {
          _state.bubbleTextList = bubbleTextList
        }
      }
      
    case let .changeMyTeam(newTeam):
      myTeamService.saveTeam(to: newTeam)
      changeAppIconService.requestChangeAppIcon(to: newTeam)
      _state.myTeam = newTeam
      self.effect(.setBubbleTexts)
      
    case let .changeMyNickname(newName):
      myNicknameService.saveNickname(to: newName)
      _state.myNickname = newName
    }
  }
}
