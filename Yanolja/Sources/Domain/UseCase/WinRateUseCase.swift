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
    var selectedYearFilter: String = YearFilter.initialValue
    
    // MARK: - Data State
    var myTeam: BaseballTeam = .noTeam
    var myTeamWinRate: Int?
    var totalWinRate: Int? = 88
    var eachTeamAnalytics: EachTeamAnalyticsModel = .init()
    var eachStadiumsAnalytics: EachStadiumsAnalyticsModel = .init()
    fileprivate var recordList: [GameRecordWithScoreModel] = []
    var filteredRecordList: [GameRecordWithScoreModel] {
      self.recordList.filtered(years: selectedYearFilter)
    }
  }
  
  // MARK: - Action
  enum Action {
    // MARK: - User Action
    case tappedTeamChange(BaseballTeam) // MARK: - 팀 변경 시 다른 형태로 값 주입 필요 (현재 기존 형태)
    case tappedAnalyticsYearFilter(to: String)
    case tappedTeamWinRateCell
    case updateRecords([GameRecordWithScoreModel]) // 새로운 기록이 추가되면 WinRate 다시 계산
    case sendMyTeamInfo(BaseballTeam)
    case setMyTeamWinRate
  }
  
  private let gameRecordInfoService: GameRecordInfoService
  private var _state: State = .init()
  var state: State { _state }
  
  init(
    recordService: RecordDataServiceInterface,
    myTeamService: MyTeamServiceInterface,
    gameRecordInfoService: GameRecordInfoService
  ) {
    self.gameRecordInfoService = gameRecordInfoService
    _state.myTeam = myTeamService.readMyTeam() ?? .noTeam
    
    switch recordService.readAllRecord() {
    case .success(let allList):
      self._state.recordList = allList
      self.totalWinRate(recordList: allList)
      self.vsAllTeamWinRate(recordList: allList)
      self.vsAllStadiumsWinRate(recordList: allList)
      
    case .failure:
      break
    }
    
    effect(.setMyTeamWinRate)
  }
  
  // MARK: - Preview용
  init(
    recordList: [GameRecordWithScoreModel],
    recordService: RecordDataServiceInterface,
    myTeamService: MyTeamServiceInterface,
    gameRecordInfoService: GameRecordInfoService
  ) {
    self.gameRecordInfoService = gameRecordInfoService
    _state.myTeam = myTeamService.readMyTeam() ?? .noTeam
    _state.recordList = recordList
    self.totalWinRate(recordList: recordList)
    self.vsAllTeamWinRate(recordList: recordList)
    self.vsAllStadiumsWinRate(recordList: recordList)
  }
  
  func effect(_ action: Action) {
    switch action {
    case .setMyTeamWinRate:
      Task {
        if case let .success(winRate) = await gameRecordInfoService.teamWinRate(_state.myTeam.sliceName) {
          _state.myTeamWinRate = winRate
        } else {
          _state.myTeamWinRate = nil
        }
      }
      
    case let .tappedTeamChange(team):
      _state.myTeam = team
      effect(.setMyTeamWinRate)
      
    case let .tappedAnalyticsYearFilter(year): // 연도 정보 토대로 필터정보 변경
      _state.selectedYearFilter = year
      let recordList = _state.recordList.filtered(years: year)
      self.vsAllTeamWinRate(recordList: recordList)
      self.vsAllStadiumsWinRate(recordList: recordList)
      
    case .tappedTeamWinRateCell:
      _state.tappedTeamWinRateCell.toggle()
      
    case .updateRecords(let records):
      self._state.recordList = records
      self.totalWinRate(recordList: records)
      self.vsAllTeamWinRate(recordList: records)
      self.vsAllStadiumsWinRate(recordList: records)
      
    case let .sendMyTeamInfo(myTeam):
      _state.myTeam = myTeam
    }
  }
  
  // MARK: - Usecase Logic
  /// 직관 기록을 통해 총 승률을 계산하고 입력합니다
  private func totalWinRate(recordList: [GameRecordWithScoreModel])  {
    
    let totalGames = recordList.filter { $0.result != .cancel }.count // 취소를 제외한 경기 중 무승부를 포함한 전체 게임 수
    let drawCount = recordList.filter { $0.result == .draw}.count // 무승부 수
    let winCount = recordList.filter { $0.result == .win}.count // 이긴 게임 수
    let winOrLoseGamesCount = totalGames - drawCount // 무승부를 제외한 전체 게임 수
    
    if winOrLoseGamesCount > 0 {
      _state.totalWinRate = Int(Double(winCount) / Double(winOrLoseGamesCount) * 100)
    } else {
      _state.totalWinRate = nil
    }
  }
  /// 직관 기록을 통해 구단 별 승률을 계산하고 입력합니다
  private func vsAllTeamWinRate(recordList: [GameRecordWithScoreModel]) {
    var teamWins: [BaseballTeam: Int] = [:]
    var teamGamesAll: [BaseballTeam: Int] = [:]
    var teamGamesNotCancel: [BaseballTeam: Int] = [:]
    var teamDraws: [BaseballTeam: Int] = [:]
    let recordList = recordList.filtered(years: state.selectedYearFilter)
    
    for record in recordList {
      let team = record.vsTeam
      teamGamesAll[team, default: 0] += 1
      
      guard record.result != .cancel else { continue } // 취소 경기는 포함하지 않음
      teamGamesNotCancel[team, default: 0] += 1
      
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
    
    for team in BaseballTeam.recordBaseBallTeam {
      let wins = teamWins[team] ?? 0
      let gamesNotCancel = teamGamesNotCancel[team] ?? 0
      let gamesAll = teamGamesAll[team]
      let draws = teamDraws[team] ?? 0
      
      vsTeamRecordCount[team] = gamesAll
      
      if gamesNotCancel-draws > 0 {
        vsTeamWinRate[team] = Int((Double(wins) / Double(gamesNotCancel-draws)) * 100)
      }
    }
    
    _state.eachTeamAnalytics.vsTeamWinRate = vsTeamWinRate
    _state.eachTeamAnalytics.vsTeamRecordCount = vsTeamRecordCount
  }
  
  /// 직관 기록을 통해 구장 별 승률을 계산하고 입력합니다
  private func vsAllStadiumsWinRate(recordList: [GameRecordWithScoreModel]) {
    var stadiumsWins: [String: Int] = [:]
    var stadiumsGamesAll: [String: Int] = [:]
    var stadiumsGamesNotCancel: [String: Int] = [:]
    var stadiumsDraws: [String: Int] = [:]
    let recordList = recordList.filtered(years: state.selectedYearFilter)
    
    for record in recordList {
      let stadiums = record.stadiums
      stadiumsGamesAll[stadiums, default: 0] += 1
      
      guard record.result != .cancel else { continue } // 취소 경기는 포함하지 않음

      stadiumsGamesNotCancel[stadiums, default: 0] += 1
      
      if record.result == .win {
        // 승리한 경우에만 승리 수 증가
        stadiumsWins[stadiums, default: 0] += 1
      }
      
      if record.result == .draw {
        // 무승부인 경우 무승부 수 증가
        stadiumsDraws[stadiums, default: 0] += 1
      }
    }
    
    // 각 팀의 승률 계산 및 상태에 저장
    var stadiumsWinRate: [String: Int?] = [:]
    var stadiumsRecordCount: [String: Int?] = [:]
    
    for stadiums in BaseballStadiums.nameList {
      let wins = stadiumsWins[stadiums] ?? 0
      let gamesNotCancel = stadiumsGamesNotCancel[stadiums] ?? 0
      let gamesAll = stadiumsGamesAll[stadiums]
      let draws = stadiumsDraws[stadiums] ?? 0
      
      stadiumsRecordCount[stadiums] = gamesAll
      
      if gamesNotCancel-draws > 0 {
        stadiumsWinRate[stadiums] = Int((Double(wins) / Double(gamesNotCancel-draws)) * 100)
      }
    }
    
    _state.eachStadiumsAnalytics.stadiumsWinRate = stadiumsWinRate
    _state.eachStadiumsAnalytics.stadiumsRecordCount = stadiumsRecordCount
  }
}
