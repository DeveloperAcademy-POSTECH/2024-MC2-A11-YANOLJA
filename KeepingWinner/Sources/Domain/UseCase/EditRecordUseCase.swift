//
//  EditRecordUseCase.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/1/25.
//

import SwiftUI

enum RecordEditType {
  case new
  case edit(RecordModel)
}

@Observable
final class EditRecordUseCase {
  // MARK: - State
  struct State {
    var _resetRecord: RecordModel = .init(stadium: .dummy, myTeam: .dummy, vsTeam: .dummyOther)
    var _realRecords: [RecordModel] = []
    var _myTeam: RecordModel?
    var _candidateMyTeamSymbol: String?
    
    var baseballTeams: [BaseballTeamModel] = []
    var _stadiums: [StadiumModel] = []
    var stadiums: [StadiumModel] {
      get { _stadiums.filter { $0.isValid(in: Int(record.date.year) ?? KeepingWinningRule.dataUpdateYear) } }
    }
    var record: RecordModel = .init(stadium: .dummy, myTeam: .dummy, vsTeam: .dummyOther)
    
    var networkLoading = false
    var teamChangeAlert = false
    
    var isDoubleHeader: Bool { return self.record.isDoubleHeader != -1 }
    var myTeamSymbol: String { return _resetRecord.myTeam.symbol }
  }
  
  // MARK: - Action
  enum Action {
    case onAppear(RecordEditType)
    case _loadBaseballTeams
    case _loadStadiums
    case _saveNewRecord
    case _saveEditRecord
    
    case _loadRealRecords(Date, String)
    case _matchRecordToRealRecordsFirst(Bool)
    case _showTeamChangeAlert(Bool)
    
    case tappedChangeMyTeamConfirmButton
    case tappedChangeDate(Date)
    case tappedChangeStadium(String)
    case tappedDoubleButton(Bool)
    case tappedChangeMyTeam(String)
    case tappedChangeVsTeam(String)
    case tappedIsCancel
    case selectPhoto(UIImage)
    case tappedPhoto
    
    case inputScoreMyTeam(Bool, String) // 내 팀인지, 스코어
    case inputMemo(String) // 내 팀인지, 스코어
    
    case tappedConfirmToNew(Bool)
    case tappedDeleteRecord
    case tappedFirstDoubleButton(Bool)// true: 왼쪽. false: 오른쪽
  }
  
  private var myRecordService: RecordDataServiceInterface = RecordDataService()
  private var userInfoService: MyTeamServiceInterface = UserDefaultsService()
  private var realRecordService: GameRecordInfoService = .live
  private var baseballTeamService: BaseballTeamService = .live
  private var stadiumService: StadiumService = .live
  private(set) var state: State = .init()
  
  init() {}
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case let .onAppear(type):
      effect(._loadStadiums)
      effect(._loadBaseballTeams)
      
      if case .edit(var exRecord) = type {
        let exStadiums = state._stadiums.filter { $0.isValid(in: Int(exRecord.date.year) ?? KeepingWinningRule.dataUpdateYear) }
        if !exStadiums.map ({ $0.symbol }).contains(exRecord.stadium.symbol) {
          let first = exStadiums.first ?? .dummy
          exRecord.stadium = first
        }
        self.state.record = exRecord
      } else {
        let recordYear = state.record.date.year
        let myTeam = self.userInfoService.readMyTeam(
          baseballTeams: state.baseballTeams
        ) ?? BaseballTeamModel.noTeam
        let recordMyTeam = myTeam.isNoTeam ? state.baseballTeams.first ?? .dummy : myTeam
        let recordVsTeam = state.baseballTeams.first(without: recordMyTeam.symbol) ?? .dummy
        let stadium = recordMyTeam.homeStadium(year: recordYear) ?? .dummy
        
        state._resetRecord.id = state.record.id
        state._resetRecord.myTeam = recordMyTeam
        state._resetRecord.vsTeam = recordVsTeam
        state._resetRecord.stadium = stadium
        state.record = state._resetRecord
        let recordDate = state.record.date
        effect(._loadRealRecords(recordDate, recordMyTeam.name(year: recordDate.year)))
      }
      
    case ._loadBaseballTeams:
      self.state.baseballTeams = self.baseballTeamService.teams()
      return
      
    case ._loadStadiums:
      self.state._stadiums = self.stadiumService.stadiums()
      return
      
    case let ._loadRealRecords(date, teamName):
      state._realRecords = []
      state.networkLoading = true
      Task {
        let result = await realRecordService.gameRecord(
          date,
          teamName,
          state.baseballTeams,
          state._stadiums
        )
        
        await MainActor.run {
          state.networkLoading = false
          
          switch result {
          case let .success(realRecords):
            guard realRecords.compactMap({ $0 }).count == realRecords.count else { return }
              state._realRecords = realRecords.compactMap { $0 }
              effect(._matchRecordToRealRecordsFirst(true))
          case .failure: break
          }
        }
      }
        
      case .tappedChangeDate(let date):
        let myTeamName = state.record.myTeam.name(year: date.year)
        state.record.date = date
        effect(._loadRealRecords(date, myTeamName))
        
      case .tappedChangeStadium(let symbol):
        state.record.stadium = state._stadiums.find(symbol: symbol) ?? .dummy
        
      case .tappedChangeMyTeam(let symbol):
        state._candidateMyTeamSymbol = symbol
        effect(._showTeamChangeAlert(true))
        
      case ._showTeamChangeAlert(let show):
        state.teamChangeAlert = show
        
      case .tappedChangeMyTeamConfirmButton:
        guard let symbol = state._candidateMyTeamSymbol else { return }
        let date = state.record.date
        state.record.vsTeam = state.baseballTeams.first(without: symbol) ?? .dummy
        state.record.myTeam = state.baseballTeams.find(symbol: symbol) ?? .dummy
        effect(._loadRealRecords(date, state.record.myTeam.name()))
        
        state._candidateMyTeamSymbol = nil
        effect(._showTeamChangeAlert(false))
        
      case .tappedChangeVsTeam(let symbol):
        let vsTeam = state.baseballTeams.find(symbol: symbol) ?? .dummy
        state.record.vsTeam = vsTeam
        
      case .tappedDoubleButton(let nowState):
        state.record.isDoubleHeader = nowState ? 0 : -1
        
      case .tappedFirstDoubleButton(let isFirst):
        if state._realRecords.count < 2 {
          state.record.isDoubleHeader = isFirst ? 0 : 1
        } else {
          effect(._matchRecordToRealRecordsFirst(isFirst))
        }
        
      case let .inputScoreMyTeam(isMyTeam, score):
        let num = Int(score.prefix(2)) ?? 0
        if isMyTeam {
          state.record.myTeamScore = String(num)
        } else {
          state.record.vsTeamScore = String(num)
        }
        
      case .tappedIsCancel:
        state.record.isCancel = !state.record.isCancel
        state.record.myTeamScore = state.record.isCancel ? "-" : "0"
        state.record.vsTeamScore = state.record.isCancel ? "-" : "0"
        
      case let .inputMemo(memo):
        state.record.memo = String(memo.prefix(100))
        
      case let .selectPhoto(photo):
        state.record.photo = photo
        
      case .tappedPhoto:
        state.record.photo = nil
        
      case ._matchRecordToRealRecordsFirst(let first):
        guard let realRecord = first ? state._realRecords.first : state._realRecords.last else { return }
        
        state.record.date = realRecord.date
        state.record.stadium = realRecord.stadium
        state.record.isDoubleHeader = realRecord.isDoubleHeader
        state.record.myTeam = realRecord.myTeam
        state.record.vsTeam = realRecord.vsTeam
        state.record.myTeamScore = realRecord.myTeamScore
        state.record.vsTeamScore = realRecord.vsTeamScore
        state.record.isCancel = realRecord.isCancel
        
      case .tappedConfirmToNew(let isNewRecord):
        isNewRecord ? effect(._saveNewRecord) : effect(._saveEditRecord)
        
      case ._saveNewRecord:
        let newRecord = state.record
        _ = myRecordService.saveRecord(newRecord)
        
      case ._saveEditRecord:
        let editRecord = state.record
        _ = myRecordService.editRecord(editRecord)
        
      case .tappedDeleteRecord:
        _ = myRecordService.removeRecord(id: state.record.id)
      }
    }
  }
