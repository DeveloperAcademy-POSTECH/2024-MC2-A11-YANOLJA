//
//  BaseballTeamType.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - 고유명사라 예외적 대문자, _ 표기
enum BaseballTeam: String, CaseIterable {
  static var myTeam: Self = .doosan // 앱 최초 진입 시 설정 
  static var otherTeams: [Self] = Self.allCases.filter { $0 != .myTeam }
  
  case doosan
  case lotte
  case samsung
  case hanhwa
  case kiwoom
  case kia
  case kt
  case lg
  case nc
  case ssg
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
    case .hanhwa:
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
    }
  }
  
  var mainColor: Color {
    switch self {
    case .doosan:
      return .doosan1
    case .lotte:
      return .lotte1
    case .samsung:
      return .samsung1
    case .hanhwa:
      return .hanhwa1
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
    case .hanhwa:
      return .hanhwa2
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
    }
  }
}
