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
    var recordList: [GameRecordWithScoreModel] = []
  }
  
  // MARK: - Action
  enum Action {
    case tappedCreateRecordSheet(Bool)
    case tappedRecordCellToEditRecordSheet(Bool)
    case tappedSaveNewRecord(GameRecordWithScoreModel)
    case tappedEditNewRecord(GameRecordWithScoreModel) 
    case tappedDeleteRecord(UUID)
  }
  
  private var recordService: RecordDataServiceInterface
  private var _state: State = .init() // 실제 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    return _state
  }
  
  init(recordService: RecordDataServiceInterface) {
    self.recordService = recordService
    // MARK: - v1.0 기존 Data 값 있다면, 변경해서 저장하고 다시 불러와서 진행
    // MARK: - v1.0 기존 Data 값 없다면, 정상 진행
    switch recordService.readAllRecord() {
    case .success(let dataList):
      _state.recordList = dataList
    case .failure:
      return
    }
  }
  
  // MARK: - Preview용 
  init(
    recordList: [GameRecordWithScoreModel],
    recordService: RecordDataServiceInterface
  ) {
    self.recordService = recordService
    self._state.recordList = recordList
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
      _ = recordService.saveRecord(newRecord)
      _state.recordList.append(newRecord)
      self._state.createRecordSheet = false
      
      // 데이터 수정 요청
    case let .tappedEditNewRecord(editRecord):
      _ = recordService.editRecord(editRecord)
      if let index = _state.recordList.map({ $0.id }).firstIndex(of: editRecord.id) {
        _state.recordList[index] = editRecord
      }
      self._state.editRecordSheet = false
      
      // 데이터 삭제 요청
    case let .tappedDeleteRecord(id):
      _ = recordService.removeRecord(id: id)
      _state.recordList = _state.recordList.filter { $0.id != id }
      self._state.editRecordSheet = false
      return
      
    }
  }
}
