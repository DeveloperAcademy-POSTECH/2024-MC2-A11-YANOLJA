//
//  HistoryUseCase.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

@Observable
class HistoryUseCase {
  struct State {
    var tappedPlusButton: Bool = false
    var tappedHistoryCell: Bool = false
    var historyList: [MatchRecordEntity] = [.init()] // 테스트 위한 더미 데이터 한 개
  }
  
  enum Action {
    case tappedAddButton
    case tappedHistoryCell
  }
  
  private var _state: State = .init()
  var state: State {
    return _state
  }
  
  func effect(_ action: Action) {
    switch action {
    case .tappedAddButton:
      self._state.tappedPlusButton.toggle()
      return
      
    case .tappedHistoryCell:
      self._state.tappedHistoryCell.toggle()
    }
  }
}
