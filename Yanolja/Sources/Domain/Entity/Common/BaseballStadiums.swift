//
//  BaseballStadiums.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

enum BaseballStadiums: String, CaseIterable {
  static var nameList: [String] = ["잠실종합운동장야구장", "인천SSG랜더스필드", "울산문수야구장", "대구삼성라이온즈파크", "창원NC파크", "부산사직야구장", "광주KIA챔피언스필드", "고척스카이돔", "포항야구장", "대전한화생명이글스파크", "수원KT위즈파크"]
  
  
  case gocheok
  case sagik
  case jamsil
  case suwon
  case incheon
  case daejeon
  case daegu
  case changwon
  case gwangju
  case pohang
  
  var name: String {
    switch self {
    case .gocheok:
      return "고척스카이돔"
    case .sagik:
      return "사직야구장"
    case .jamsil:
      return "잠실야구장"
    case .suwon:
      return "수원KT위즈파크"
    case .incheon:
      return "인천SSG랜더스필드"
    case .daejeon:
      return "대전한화생명이글스파크"
    case .daegu:
      return "대구삼성라이온즈파크"
    case .changwon:
      return "창원NC파크"
    case .gwangju:
      return "광주기아챔피언스필드"
    case .pohang:
      return "포항야구장"
    }
  }
  
  var convertName: String {
    switch self {
    case .gocheok:
      return "고척스카이돔"
    case .sagik:
      return "부산사직야구장"
    case .jamsil:
      return "잠실종합운동장야구장"
    case .suwon:
      return "수원KT위즈파크"
    case .incheon:
      return "인천SSG랜더스필드"
    case .daejeon:
      return "대전한화생명이글스파크"
    case .daegu:
      return "대구삼성라이온즈파크"
    case .changwon:
      return "창원NC파크"
    case .gwangju:
      return "광주KIA챔피언스필드"
    case .pohang:
      return "포항야구장"
    }
  }
  
  static var allStadiums: [BaseballStadiums] {
    return Self.allCases
  }
}
