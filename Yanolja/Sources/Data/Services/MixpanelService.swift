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
  func tappedMainCharacter() {
    Mixpanel.mainInstance().track(event: "TabCharacter")
    Mixpanel.mainInstance().people.increment(property: "tab_character", by: 1)
  }
  
  func tappedPlusButtonToMakeRecord() {
    Mixpanel.mainInstance().track(event: "RecordButton")
    Mixpanel.mainInstance().people.increment(property: "record_button", by: 1)
  }
  
  func tappedConfirmButtonToRecord() {
    Mixpanel.mainInstance().track(event: "CompleteButton")
    Mixpanel.mainInstance().people.increment(property: "complete_button", by: 1)
  }
  
  func tappedConfirmButtonWithMemo(_ count: Int) {
    Mixpanel.mainInstance().track(event: "WriteMemo", properties: ["write_memo_length": count])
  }
  
  func tappedConfirmButtonWithPhoto(_ exists: Bool) {
    Mixpanel.mainInstance().track(event: "UploadPicture", properties: ["uploaded_picture": exists])
  }
}
