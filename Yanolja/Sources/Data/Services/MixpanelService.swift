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
    
  }
  
  func tappedConfirmButtonToRecord() {
    
  }
  
  func tappedConfirmButtonWithMemo() {
    
  }
  
  func tappedConfirmButtonWithPhoto() {
    
  }
}
