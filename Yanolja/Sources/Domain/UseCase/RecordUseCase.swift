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
    var recordList: [GameRecordModel] = [
      .init(vsTeam: .kia, gameResult: .draw),
        .init(vsTeam: .ssg, stadiums: .jamsil)
    ] // 테스트 위한 더미 데이터 한 개
  }
  
  // MARK: - Action
  enum Action {
    case tappedCreateRecordSheet(Bool)
    case tappedRecordCellToEditRecordSheet(Bool)
    case tappedSaveNewRecord(GameRecordModel)
    case tappedEditNewRecord(GameRecordModel)
    case tappedDeleteRecord(UUID)
  }
  
  private var _state: State = .init() // 실제 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    return _state
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case let .tappedCreateRecordSheet(result):
      self._state.createRecordSheet = result
      return
      
    case let .tappedRecordCellToEditRecordSheet(result):
      self._state.editRecordSheet = result
    case let .tappedSaveNewRecord(newRecord):
      // 데이터에 저장
      self._state.createRecordSheet = false
    case let .tappedEditNewRecord(editRecord):
      // 데이터 수정 요청
      self._state.editRecordSheet = false
    case let .tappedDeleteRecord(id):
      // 데이터 삭제 요청
      self._state.editRecordSheet = false
      return
    }
    
  }
}
