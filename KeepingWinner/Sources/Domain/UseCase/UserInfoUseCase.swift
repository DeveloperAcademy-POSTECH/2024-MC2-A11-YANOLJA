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
    var baseballTeams: [BaseballTeamModel] = []

    var myTeam: BaseballTeamModel = .noTeam
    var myNickname: String?
    var bubbleTextList: [String] = KeepingWinningRule.defaultBubbleTexts
    var notices: [NoticeModel] = []
  }
  
  enum Action {
    case changeMyTeam(BaseballTeamModel)
    case changeMyNickname(String)
    case setNotices
    case setBubbleTexts
    case onAppear
  }
  
  private var myTeamService: MyTeamServiceInterface
  private var myNicknameService: MyNicknameServiceInterface
  private var changeAppIconService: ChangeAppIconInterface
  private var settingsService: SettingsService
  private var baseballTeamService: BaseballTeamService = .live
  private(set) var state: State = .init()
  
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
    state.myNickname = myNicknameService.readMyNickname()
    state.baseballTeams = baseballTeamService.teams()
    state.myTeam = myTeamService.readMyTeam(baseballTeams: state.baseballTeams)
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case .onAppear:
      self.effect(.setNotices)
      self.effect(.setBubbleTexts)
      
    case .setNotices:
      Task {
        if case let .success(notices) = await settingsService.allNotices() {
          await MainActor.run {
            state.notices = notices
          }
        }
      }
      
    case .setBubbleTexts:
      Task {
        let myTeamName = state.myTeam.name()
        if case let .success(
          bubbleTextList
        ) = await settingsService.characterBubbleTexts(myTeamName) {
          await MainActor.run {
            self.state.bubbleTextList = bubbleTextList
          }
        } else {
          await MainActor.run {
            self.state.bubbleTextList = KeepingWinningRule.defaultBubbleTexts
          }
        }
      }
      
    case let .changeMyTeam(newTeam):
      let symbol = newTeam.symbol
      myTeamService.saveTeam(symbol: symbol)
      changeAppIconService.requestChangeAppIcon(symbol: symbol) 
      state.myTeam = newTeam
      self.effect(.setBubbleTexts)
      
    case let .changeMyNickname(newName):
      myNicknameService.saveNickname(to: newName)
      state.myNickname = newName
    }
  }
}
