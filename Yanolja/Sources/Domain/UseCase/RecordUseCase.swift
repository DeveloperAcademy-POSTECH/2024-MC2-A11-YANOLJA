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
    var tappedPlusButton: Bool = false
    var tappedRecordCell: Bool = false
    
    // MARK: - Data State
    var recordList: [GameRecordModel] = [
      .init(vsTeam: .kia, gameResult: .draw),
        .init(vsTeam: .ssg, stadiums: .jamsil)
    ] // 테스트 위한 더미 데이터 한 개
  }
  
  // MARK: - Action
  enum Action {
    case tappedAddButton
    case tappedRecordCell
  }
  
  private var _state: State = .init() // 실제 원본 State, Usecase 내부에서만 접근가능
  var state: State { // View에서 접근하는 state
    return _state
  }
  
  // MARK: - View Action
  func effect(_ action: Action) {
    switch action {
    case .tappedAddButton:
      self._state.tappedPlusButton.toggle()
      return
      
    case .tappedRecordCell:
      self._state.tappedRecordCell.toggle()
    }
  }
}
