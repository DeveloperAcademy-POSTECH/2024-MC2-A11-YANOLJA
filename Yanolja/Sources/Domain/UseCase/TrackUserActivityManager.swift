//
//  TrackUserActivityManager.swift
//  Yanolja
//
//  Created by 박혜운 on 1/23/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation

class TrackUserActivityManager {
  enum Action {
    case tappedMainCharacter
    case tappedPlusButtonToMakeRecord
    case tappedConfirmButtonToRecord(memo: Bool, photo: Bool)
  }
  
  static var shared: TrackUserActivityManager = .init()
  
  private init() {}
  
  private var trackService: TrackUserActivityService?
  
  func configure(service: TrackUserActivityService) {
    self.trackService = service
  }
  
  func effect(_ action: Action) {
    switch action {
    case .tappedMainCharacter:
      
    case .tappedPlusButtonToMakeRecord:
      break
    case let .tappedConfirmButtonToRecord(memo, photo):
      break 
    }
  }
}
