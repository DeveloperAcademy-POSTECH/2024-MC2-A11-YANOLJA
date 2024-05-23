//
//  RecordUseCase.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

@Observable
class RecordUseCase {
  // MARK: - State
  struct State {
    // MARK: - View State
    var createRecordSheet: Bool = false
    var editRecordSheet: Bool = false
    
    // MARK: - Data State
    var recordList: [GameRecordModel] = []
  }
  
  // MARK: - Action
  enum Action {
    case tappedCreateRecordSheet(Bool)
    case tappedRecordCellToEditRecordSheet(Bool)
    case tappedSaveNewRecord(GameRecordModel)
    case tappedEditNewRecord(GameRecordModel)
    case tappedDeleteRecord(UUID)
  }
  
  private var dataService: DataServiceInterface
  private var _state: State = .init() // 실제 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    return _state
  }
  
  init(dataService: DataServiceInterface) {
    self.dataService = dataService
    
    switch dataService.readAllRecord() {
    case .success(let dataList):
      _state.recordList = dataList
    case .failure:
      return
    }
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case let .tappedCreateRecordSheet(result):
      self._state.createRecordSheet = result
      return
      
    case let .tappedRecordCellToEditRecordSheet(result):
      self._state.editRecordSheet = result
      
      // 데이터 저장 요청
    case let .tappedSaveNewRecord(newRecord):
      _ = dataService.saveRecord(newRecord)
      _state.recordList.append(newRecord)
      self._state.createRecordSheet = false
      
      // 데이터 수정 요청
    case let .tappedEditNewRecord(editRecord):
      _ = dataService.editRecord(editRecord)
      if let index = _state.recordList.map({ $0.id }).firstIndex(of: editRecord.id) {
        _state.recordList[index] = editRecord
      }
      self._state.editRecordSheet = false
      
      // 데이터 삭제 요청
    case let .tappedDeleteRecord(id):
      _ = dataService.removeRecord(id: id)
      _state.recordList = _state.recordList.filter { $0.id != id }
      self._state.editRecordSheet = false
      return
    }
  }
}
