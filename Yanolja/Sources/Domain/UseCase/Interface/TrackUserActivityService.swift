//
//  TrackUserActivityService.swift
//  Yanolja
//
//  Created by 박혜운 on 1/23/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation

protocol TrackUserActivityService {
  func tappedMainCharacter()
  func tappedPlusButtonToMakeRecord()
  func tappedConfirmButtonToRecord()
  func tappedConfirmButtonWithMemo(_ count: Int)
  func tappedConfirmButtonWithPhoto(_ exists: Bool)
}
