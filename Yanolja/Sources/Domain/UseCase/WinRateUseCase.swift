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
  // MARK: - State
  struct State {
    // MARK: - View State
    var tappedTeamWinRateCell: Bool = false
    
    // MARK: - Data State
    var myTeam: BaseballTeam = BaseballTeam.myTeam
    var myWinRate: WinRateModel = .init(totalWinRate: 40)
  }
  
  // MARK: - Action
  enum Action {
    // MARK: - User Action
    case requestTeamChange(BaseballTeam)
    case tappedTeamWinRateCell
    case saveNewRecord(GameRecordModel) // 새로운 기록이 추가되면 WinRate 다시 계산
  }
  
  private var dataService: DataServiceInterface
  private var _state: State = .init() // 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    _state
  }
  
  init(dataService: DataServiceInterface) {
    self.dataService = dataService
    switch dataService.readAllRecord() {
    case .success(let allList):
      self.totalWinRate(recordList: allList)
      self.vsAllTeamWinRate(recordList: allList)
    case .failure: return
    }
  }
  
  func effect(_ action: Action) {
    switch action {
    case .requestTeamChange(let team):
      BaseballTeam.myTeam = team
      _state.myTeam = team
      
    case .tappedTeamWinRateCell:
      _state.tappedTeamWinRateCell.toggle()
      
    case .saveNewRecord(let new):
      switch self.dataService.saveRecord(new) {
      case .success:
      self.editWinRate(add: new) // 변경하고
      self.editVsTeamWinRate(add: new) // 변경하고
      case .failure: return
      }
    }
  }
  
  // MARK: - Usecase Logic
  /// 직관 기록을 통해 총 승률을 계산하고 입력합니다
  private func totalWinRate(recordList: [GameRecordModel]) {
    // recordList를 토대로 총 승률 계산
    // _state.myWinRate.totalWinRate = 계산값 입력
    
  }
  /// 직관 기록을 통해 구단 별 승률을 계산하고 입력합니다
  private func vsAllTeamWinRate(recordList: [GameRecordModel]) {
    // recordList를 토대로 구단 별 승률 계산
    // _state.myWinRate.vsTeamWinRate = 계산값 입력
  }
  
  private func editWinRate(add: GameRecordModel) {
    // 추가된 기록을 토대로 전체 승률 변경
  }
  
  private func editVsTeamWinRate(add: GameRecordModel) {
    // 구단 확인 후 특정 구단 승률 갱신
    // _state.myWinRate.vsTeamWinRate[특정구단] = 계산값 입력
  }
}
