//
//  MixpanelService.swift
//  Yanolja
//
//  Created by 박혜운 on 1/23/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation
import Mixpanel

struct MixpanelService: TrackUserActivityService {
  func initialize(token: String) {
    Mixpanel.initialize(token: token)
  }
  
  func tappedMainCharacter() {
    let type = MixpanelDTO.tabCharacter
    Mixpanel.mainInstance().track(event: type.event)
    Mixpanel.mainInstance().people.increment(property: type.property, by: 1)
  }
  
  func tappedPlusButtonToMakeRecord() {
    let type = MixpanelDTO.recordButton
    Mixpanel.mainInstance().track(event: type.event)
    Mixpanel.mainInstance().people.increment(property: type.property, by: 1)
  }
  
  func tappedConfirmButtonToRecord() {
    let type = MixpanelDTO.completeButton
    Mixpanel.mainInstance().track(event: type.event)
    Mixpanel.mainInstance().people.increment(property: type.property, by: 1)
  }
  
  func tappedConfirmButtonWithMemo(_ count: Int) {
    let type = MixpanelDTO.writeMemo
    Mixpanel.mainInstance().track(event: type.event, properties: [type.property: count])
  }
  
  func tappedConfirmButtonWithPhoto(_ exists: Bool) {
    let type = MixpanelDTO.uploadPicture
    Mixpanel.mainInstance().track(event: type.event, properties: [type.property: exists])
  }
}
