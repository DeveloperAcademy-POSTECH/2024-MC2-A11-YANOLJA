//
//  SettingsAPI.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum SettingsAPI {
  case characterBubbleTexts(myTeam: String)
  case allStadiums
  case allNotices
}

extension SettingsAPI: EndPointType {
  var baseURL: String { return .baseURL }
  
  var path: String {
    switch self {
    case .characterBubbleTexts: return "/teamLine"
    case .allStadiums: return "/stadiums"
    case .allNotices: return "/notices"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .characterBubbleTexts: return .post
    case .allStadiums: return .get
    case .allNotices: return .get
    }
  }
  
  var task: HTTPTask {
    switch self {
    case let .characterBubbleTexts(myTeam): return .requestParameters(
      parameters: ["myTeam": myTeam],
      encoding: .jsonBody
    )
      
    case .allStadiums: return .requestPlain
    case .allNotices: return .requestPlain
    }
  }
}
