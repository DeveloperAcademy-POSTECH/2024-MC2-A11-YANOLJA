//
//  MixpanelEventDTO.swift
//  Yanolja
//
//  Created by 박혜운 on 1/24/25.
//  Copyright © 2025 com.mc2. All rights reserved.
//

import Foundation

enum MixpanelDTO {
  case tabCharacter
  case recordButton
  case completeButton
  case writeMemo
  case uploadPicture
  case viewCard
  case saveCard
  case shareInsta
  
  var event: String {
    switch self {
    case .tabCharacter:    "TabCharacter"
    case .recordButton:    "RecordButton"
    case .completeButton:  "CompleteButton"
    case .writeMemo:       "WriteMemo"
    case .uploadPicture:   "UploadPicture"
    case .viewCard:        "ViewCard"
    case .saveCard:        "SaveCard"
    case .shareInsta:      "ShareInsta"
    }
  }
  
  var property: String {
    switch self {
    case .tabCharacter:    "tab_character"
    case .recordButton:    "record_button"
    case .completeButton:  "complete_button"
    case .writeMemo:       "write_memo_length"
    case .uploadPicture:   "uploaded_picture"
    case .viewCard:        "view_card"
    case .saveCard:        "save_card"
    case .shareInsta:      "share_insta"
    }
  }
}
