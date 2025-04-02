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
    var baseballTeams: [BaseballTeamModel] = []
    var stadiums: [StadiumModel] = []
    
    // MARK: - Data State
    var myTeam: BaseballTeamModel = BaseballTeamModel.noTeam
    var myTeamRealWinRate: Int?
    var isAscending: Bool = true
    
    var isPresentedYearFilterSheet: Bool = false
    var selectedYearFilter: String = YearFilter.initialValue
    
    fileprivate var records: [RecordModel] = []
    var groupingOptions: [RecordGrouping] = []
    var selectedGroupingOption: RecordGrouping = WeekdayRecordGrouping()
    
    var selectedGroupingOptionCategories: [String] = []
    var selectedGroupingOptionRecords: [String: [RecordModel]] = [:]
    
    var recordWinRate: Int? { self.records.winRate }
    var yearFilteredRecordList: [RecordModel] {
      if selectedYearFilter != "전체" {
        return self.records.filter { $0.date.year == selectedYearFilter }
      } else {
        return self.records
      }
    }
  }
  
  // MARK: - Action
  enum Action {
    // MARK: - User Action
    case tappedTeamChange(BaseballTeamModel) // MARK: - 팀 변경 시 다른 형태로 값 주입 필요 (현재 기존 형태)
    case setYearFilter(to: String)
    case presentingYearFilter(Bool)
    
    case _loadBaseballTeams
    case _loadStadiums
    case _loadMyTeamInfo
    
    case _loadAllRecords([BaseballTeamModel], [StadiumModel])
    case _setGroupingOptions
    
    case tappedGroupingOption(any RecordGrouping)
    case _sortCategories
    
    case tappedAscending
    
    case newRecord(RecordModel) // 새로운 기록이 추가되면 WinRate 다시 계산
    case editRecord(RecordModel)
    case removeRecord(UUID)
    
    case _loadMyTeamWinRate
    case onAppear
  }
  
  private let gameRecordInfoService: GameRecordInfoService
  private let recordService: RecordDataServiceInterface
  private var userInfoService: MyTeamServiceInterface
  private var baseballTeamService: BaseballTeamService = .live
  private var stadiumService: StadiumService = .live
  private(set) var state: State = .init()
  
  init(
    recordService: RecordDataServiceInterface,
    myTeamService: MyTeamServiceInterface,
    gameRecordInfoService: GameRecordInfoService
  ) {
    self.recordService = recordService
    self.gameRecordInfoService = gameRecordInfoService
    self.userInfoService = myTeamService
  }
  
  func effect(_ action: Action) {
    switch action {
    case .onAppear:
      effect(._loadBaseballTeams)
      effect(._loadStadiums)
      effect(._loadMyTeamInfo)
      effect(._loadAllRecords(state.baseballTeams, state.stadiums))
      effect(._setGroupingOptions)
      
    case let ._loadAllRecords(baseballTeams, stadiums):
      switch recordService
        .readAllRecord(baseballTeams: baseballTeams, stadiums: stadiums) {
      case .success(let records):
        self._state.records = records
        
      case .failure:
        break
      }
      
    case ._loadBaseballTeams:
      self.state.baseballTeams = self.baseballTeamService.teams()
      return
      
    case ._loadStadiums:
      self.state.stadiums = self.stadiumService.stadiums()
      return
      
    case ._loadMyTeamInfo:
      let myTeam = self.userInfoService.readMyTeam(baseballTeams: state.baseballTeams)
      self.state.myTeam = myTeam ?? BaseballTeamModel.noTeam
//      if !self.state.myTeam.isNoTeam {
//        effect(._loadMyTeamWinRate)
//      }
      
    case ._loadMyTeamWinRate:
      Task { await loadMyTeamWinRate() }
      
    case let .tappedGroupingOption(selectedGrouping):
      let yearFilterRecords = state.yearFilteredRecordList
      var optionRecords: [String: [RecordModel]] = [:]
      
      for category in selectedGrouping
        .categories(validYear: state.selectedYearFilter) {
        optionRecords[category, default: []] = yearFilterRecords.filter {
          selectedGrouping.matchesCategory(record: $0, category: category)
        }
      }
      
      state.selectedGroupingOptionRecords = optionRecords
      state.selectedGroupingOption = selectedGrouping
      effect(._sortCategories)
      
    case .tappedAscending:
      state.isAscending.toggle()
      effect(._sortCategories)
      
    case .presentingYearFilter(let presenting):
      state.isPresentedYearFilterSheet = presenting
      
    case ._sortCategories:
      let categories = state.selectedGroupingOption.categories(validYear: state.selectedYearFilter)
      
      state.selectedGroupingOptionCategories = categories.sorted { lhs, rhs in
        let leftRecords = state.selectedGroupingOptionRecords[lhs] ?? []
        let rightRecords = state.selectedGroupingOptionRecords[rhs] ?? []
        
        let leftWinRate = leftRecords.winRate ?? -1
        let rightWinRate = rightRecords.winRate ?? -1
        
        let isLeftCancelled = leftWinRate == -1
        let isRightCancelled = rightWinRate == -1
        
        // 둘 다 취소 경기
        if isLeftCancelled && isRightCancelled {
          // 동일한 경기 수라면 custom sort 기준
          if leftRecords.count == rightRecords.count {
            return state.selectedGroupingOption.sortPriority(lhs, rhs)
          }
          // 더 많은 경기 수 우선
          return leftRecords.count > rightRecords.count
        }
        
        // 한쪽만 취소 경기
        if isLeftCancelled { return false }
        if isRightCancelled { return true }
        
        // 둘 다 정상 경기
        if leftWinRate == rightWinRate {
          return state.selectedGroupingOption.sortPriority(lhs, rhs)
        }
        
        // 승률 기준 정렬
        return state.isAscending ? leftWinRate > rightWinRate : leftWinRate < rightWinRate
      }
      
      
    case ._setGroupingOptions:
      let baseballGrouping = BaseballTeamRecordGrouping(
        baseballTeams: state.baseballTeams,
        myTeam: state.myTeam
      )
      let stadiumGrouping = StadiumRecordGrouping(
        stadiums: state.stadiums,
        myRecords: state.records
      )
      let homeAwayGrouping = HomeAwayRecordGrouping(
        myTeam: state.myTeam,
        stadiums: state.stadiums
      )
      let weekdayGrouping = WeekdayRecordGrouping()
      
      state.groupingOptions = [
        baseballGrouping,
        stadiumGrouping,
        homeAwayGrouping,
        weekdayGrouping
      ]
      effect(.tappedGroupingOption(baseballGrouping))
      
    case let .tappedTeamChange(team):
      state.myTeam = team
      effect(._setGroupingOptions)
      effect(._loadMyTeamWinRate)
      
    case let .setYearFilter(year):
      state.selectedYearFilter = year
      effect(.tappedGroupingOption(state.selectedGroupingOption))
      
    case .newRecord(let record):
      state.records.append(record)
      effect(.tappedGroupingOption(state.selectedGroupingOption))
      
    case .editRecord(let record):
      guard let index = self.state.records.firstIndex(where: { $0.id == record.id }) else { return }
      self.state.records[index] = record
      effect(.tappedGroupingOption(state.selectedGroupingOption))
      
    case .removeRecord(let id):
      guard let index = self.state.records.firstIndex(where: { $0.id == id }) else { return }
      self.state.records.remove(at: index)
      effect(.tappedGroupingOption(state.selectedGroupingOption))
    }
  }
  
  @MainActor
  func loadMyTeamWinRate() async {
    let result = await gameRecordInfoService.teamWinRate(state.myTeam.name())
    
    if case let .success(winRate) = result {
      state.myTeamRealWinRate = winRate
    } else {
      state.myTeamRealWinRate = nil
    }
  }
}
