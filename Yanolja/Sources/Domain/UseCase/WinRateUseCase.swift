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
    var myTeam: BaseballTeam = .doosan
    var myWinRate: WinRateModel = .init(totalWinRate: 40)
    var myWinCount: Int = 0
    var myLoseCount: Int = 0
    var myDrawCount: Int = 0
  }
  
  // MARK: - Action
  enum Action {
    // MARK: - User Action
    case tappedTeamChange(BaseballTeam)
    case tappedTeamWinRateCell
    case updateRecords([GameRecordModel]) // 새로운 기록이 추가되면 WinRate 다시 계산
    case sendMyTeamInfo(BaseballTeam)
  }

  
  private var dataService: DataServiceInterface
  private var _state: State = .init() // 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    _state
  }
  
  init(
    dataService: DataServiceInterface,
    myTeamService: MyTeamServiceInterface
  ) {
    self.dataService = dataService

    _state.myTeam = myTeamService.readMyTeam() ?? .doosan
    
    switch dataService.readAllRecord() {
    case .success(let allList):
      self.totalWinRate(recordList: allList)
      self.vsAllTeamWinRate(recordList: allList)
      
    case .failure:
      break
    }
  }
  
  func effect(_ action: Action) {
    switch action {
    case let .tappedTeamChange(team):
      _state.myTeam = team
      
    case .tappedTeamWinRateCell:
      _state.tappedTeamWinRateCell.toggle()
      
    case .updateRecords(let records):
      self.totalWinRate(recordList: records)
      self.vsAllTeamWinRate(recordList: records)
      
    case let .sendMyTeamInfo(myTeam):
      _state.myTeam = myTeam
    }
  }
  
  // MARK: - Usecase Logic
  /// 직관 기록을 통해 총 승률을 계산하고 입력합니다
  private func totalWinRate(recordList: [GameRecordModel])  {
    
    let totalGames = recordList.count // 무승부를 포함한 전체 게임 수
    let drawCount = recordList.filter{ $0.result == .draw}.count // 무승부 수
    let winCount = recordList.filter{ $0.result == .win}.count // 이긴 게임 수
    let winRateGames = totalGames - drawCount // 무승부를 제외한 전체 게임 수
    _state.myWinRate.totalRecordCount = winRateGames
    
    guard winRateGames > 0 else {
      _state.myWinRate.totalWinRate = nil
      return
    }
    let winRate = Int(Double(winCount) / Double(winRateGames) * 100)
    _state.myWinRate.totalWinRate = winRate
  }
  /// 직관 기록을 통해 구단 별 승률을 계산하고 입력합니다
  private func vsAllTeamWinRate(recordList: [GameRecordModel]) {
    var teamWins: [BaseballTeam: Int] = [:]
    var teamGames: [BaseballTeam: Int] = [:]
    var teamDraws: [BaseballTeam: Int] = [:]
    
    for record in recordList {
      let team = record.vsTeam

      teamGames[team, default: 0] += 1
      
      if record.result == .win {
        // 승리한 경우에만 승리 수 증가
        teamWins[team, default: 0] += 1
      }
       
      if record.result == .draw {
        // 무승부인 경우 무승부 수 증가
        teamDraws[team, default: 0] += 1
      }
    }
    
    // 각 팀의 승률 계산 및 상태에 저장
    var vsTeamWinRate: [BaseballTeam: Int?] = [:]
    var vsTeamRecordCount: [BaseballTeam: Int?] = [:]
    
    for team in BaseballTeam.allCases {
      let wins = teamWins[team] ?? 0
      let games = teamGames[team] ?? 0
      let draws = teamDraws[team] ?? 0
      
      vsTeamRecordCount[team] = games
      
      if games-draws > 0 {
        vsTeamWinRate[team] = Int((Double(wins) / Double(games-draws)) * 100)
      }
    }
    
    _state.myWinRate.vsTeamWinRate = vsTeamWinRate
    _state.myWinRate.vsTeamRecordCount = vsTeamRecordCount
  }
}
