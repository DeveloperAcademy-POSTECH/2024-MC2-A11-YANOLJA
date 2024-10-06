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
    var myTeam: BaseballTeam = .noTeam
    var myWinRate: WinRateModel = .init(totalWinRate: 40)
    var myWinCount: Int = 0
    var myLoseCount: Int = 0
    var myDrawCount: Int = 0
  }
  
  // MARK: - Action
  enum Action {
    // MARK: - User Action
    case tappedTeamChange(BaseballTeam) // MARK: - 팀 변경 시 다른 형태로 값 주입 필요 (현재 기존 형태)
    case tappedTeamWinRateCell
    case updateRecords([GameRecordWithScoreModel]) // 새로운 기록이 추가되면 WinRate 다시 계산
    case sendMyTeamInfo(BaseballTeam)
  }

  private var _state: State = .init()
  var state: State { _state }
  
  init(
    recordService: RecordDataServiceInterface,
    myTeamService: MyTeamServiceInterface
  ) {
    _state.myTeam = myTeamService.readMyTeam() ?? .noTeam
    
    switch recordService.readAllRecord() {
    case .success(let allList):
      // MARK: - 기존 Data 값 있다면, 변경해서 저장하고 다시 불러와서 진행
      // MARK: - 기존 Data 값 없다면, 정상 진행
      self.totalWinRate(recordList: allList)
      self.vsAllTeamWinRate(recordList: allList)
      self.allRecordResult(recordList: allList)
      
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
      self.allRecordResult(recordList: records)
      
    case let .sendMyTeamInfo(myTeam):
      _state.myTeam = myTeam
    }
  }
  
  // MARK: - Usecase Logic
  /// 직관 기록을 통해 총 승률을 계산하고 입력합니다
  private func totalWinRate(recordList: [GameRecordWithScoreModel])  {
    
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
  private func vsAllTeamWinRate(recordList: [GameRecordWithScoreModel]) {
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
  
  /// 직관 기록을 통해 승, 패, 무 숫자를 갱신합니다
  private func allRecordResult(recordList: [GameRecordWithScoreModel]) {
    var winCount: Int = 0
    var loseCount: Int = 0
    var drawCount: Int = 0
    for record in recordList {
      guard !record.isCancel else { continue }
      switch record.result {
      case .win:
        winCount += 1
      case .lose:
        loseCount += 1
      case .draw:
        drawCount += 1
      }
    }
    _state.myWinCount = winCount
    _state.myLoseCount = loseCount
    _state.myDrawCount = drawCount
  }
}
