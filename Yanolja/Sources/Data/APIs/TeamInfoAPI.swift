//
//  TeamInfoAPI.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum TeamInfoAPI {
  case gameRecord(date: String, myTeam: String)
  case characterDialogue(myTeam: String)
  case teamWinRate(myTeam: String)
  case allStadiums
}

extension TeamInfoAPI: EndPointType {
  var baseURL: String {
    return .baseURL
  }
  
  var path: String {
    switch self {
    case .gameRecord: return "/baseballGame"
    case .characterDialogue: return "/teamLine"
    case .teamWinRate: return "/teamWinRate"
    case .allStadiums: return "/stadiums"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .gameRecord: return .post
    case .characterDialogue: return .post
    case .teamWinRate: return .post
    case .allStadiums: return .get
    }
  }
  
  var task: HTTPTask {
    switch self {
    case let .gameRecord(date, myTeam): return .requestParameters(
      parameters: ["date": date, "myTeam": myTeam],
      encoding: .queryString
    )
    case let .characterDialogue(myTeam): return .requestParameters(
      parameters: ["myTeam": myTeam],
      encoding: .queryString
    )
    case let .teamWinRate(myTeam): return .requestParameters(
      parameters: ["myTeam": myTeam],
      encoding: .queryString
    )
    case .allStadiums: return .requestPlain
    }
  }
}
