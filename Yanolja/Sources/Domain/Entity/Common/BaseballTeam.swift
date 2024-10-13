//
//  BaseballTeam.swift
//  Yanolja
//
//  Created by 박혜운 on 10/6/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation
import SwiftUI

enum BaseballTeam: String, CaseIterable {
  case doosan
  case lotte
  case samsung
  case hanwha
  case kiwoom
  case kia
  case kt
  case lg
  case nc
  case ssg
  case noTeam
  
  static let recordBaseBallTeam: [Self] = [.doosan, .lotte, .samsung, .hanwha, .kiwoom, .kia, .kt, .lg, .nc, .ssg]
}

extension BaseballTeam {
  var name: String {
    switch self {
    case .doosan:
      return "두산 베어스"
    case .lotte:
      return "롯데 자이언츠"
    case .samsung:
      return "삼성 라이온즈"
    case .hanwha:
      return "한화 이글스"
    case .kiwoom:
      return "키움 히어로즈"
    case .kia:
      return "KIA 타이거즈"
    case .kt:
      return "KT 위즈"
    case .lg:
      return "LG 트윈스"
    case .nc:
      return "NC 다이노스"
    case .ssg:
      return "SSG 랜더스"
    case .noTeam:
      return "무직"
    }
  }
  
  var sliceName: String { self.name.components(separatedBy: " ")[0] }
  
  var mainColor: Color {
    switch self {
    case .doosan:
      return .doosan1
    case .lotte:
      return .lotte1
    case .samsung:
      return .samsung1
    case .hanwha:
      return .hanwha1
    case .kiwoom:
      return .kiwoom1
    case .kia:
      return .kia1
    case .kt:
      return .kt1
    case .lg:
      return .lg1
    case .nc:
      return .nc1
    case .ssg:
      return .ssg1
    case .noTeam:
      return .noTeam1
    }
  }
  
  var subColor: Color {
    switch self {
    case .doosan:
      return .doosan2
    case .lotte:
      return .lotte2
    case .samsung:
      return .samsung2
    case .hanwha:
      return .hanwha2
    case .kiwoom:
      return .kiwoom2
    case .kia:
      return .kia2
    case .kt:
      return .kt2
    case .lg:
      return .lg2
    case .nc:
      return .nc2
    case .ssg:
      return .ssg2
    case .noTeam:
      return .noTeam2
    }
  }
  
  var image: Image {
    switch self {
    case .doosan:
      return Image(.doosan)
    case .lotte:
      return Image(.lotte)
    case .samsung:
      return Image(.samsung)
    case .hanwha:
      return Image(.hanwha)
    case .kiwoom:
      return Image(.kiwoom)
    case .kia:
      return Image(.KIA)
    case .kt:
      return Image(.KT)
    case .lg:
      return Image(.LG)
    case .nc:
      return Image(.NC)
    case .ssg:
      return Image(.SSG)
    case .noTeam:
      return Image(.noTeam)
    }
  }
  
  static let noTeamBubbleTexts: [String] = [ "오늘은 누구 응원할까", "내가 혹시 승리요정?", "어느 구단으로 취직하지", "이기는 팀 우리 팀", "홈런 가자!"]
  
  func anyOtherTeam() -> BaseballTeam {
    return BaseballTeam.allCases.filter { $0 != self }.first ?? .doosan
  }
}
