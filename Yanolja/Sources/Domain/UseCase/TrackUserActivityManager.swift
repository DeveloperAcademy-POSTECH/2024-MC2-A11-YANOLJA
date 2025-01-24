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
    case mainTabOnAppear
    case tappedMainCharacter
    case tappedPlusButtonToMakeRecord
    case tappedConfirmButtonToRecord(recording: GameRecordWithScoreModel)
  }
  
  static var shared: TrackUserActivityManager = .init()
  
  private init() {}
  
  private var trackService: TrackUserActivityService?
  private var tappedMainCharacter: Bool = false
  
  func configure(token: String, service: TrackUserActivityService) {
    service.initialize(token: token)
    self.trackService = service
  }
  
  func effect(_ action: Action) {
    switch action {
    case .mainTabOnAppear:
      tappedMainCharacter = false
      
    case .tappedMainCharacter:
      trackMainCharacterTapped()
      tappedMainCharacter = true
      
    case .tappedPlusButtonToMakeRecord:
      trackPlusButtonTapped()
      
    case let .tappedConfirmButtonToRecord(recording):
      trackConfirmButtonTapped()
      trackConfirmButton(withMemo: recording.memo)
      trackConfirmButton(withPhotoExists: recording.photo != nil)
    }
  }
  
  private func trackMainCharacterTapped() {
    guard !tappedMainCharacter else { return }
    trackService?.tappedMainCharacter()
  }
  
  private func trackPlusButtonTapped() {
    trackService?.tappedPlusButtonToMakeRecord()
  }
  
  private func trackConfirmButtonTapped() {
    trackService?.tappedConfirmButtonToRecord()
  }
  
  private func trackConfirmButton(withMemo memo: String?) {
    guard let memo else { return }
    trackService?.tappedConfirmButtonWithMemo(memo.count)
  }
  
  private func trackConfirmButton(withPhotoExists exists: Bool) {
    trackService?.tappedConfirmButtonWithPhoto(exists)
  }
}
