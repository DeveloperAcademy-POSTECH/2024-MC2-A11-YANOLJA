//
//  TeamInfoAPI.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum GameRecordInfoAPI {
  case realRecord(date: String, myTeam: String)
  case teamWinRate(myTeam: String)
}

extension GameRecordInfoAPI: EndPointType {
  var baseURL: String {
    return .baseURL
  }
  
  var path: String {
    switch self {
    case .realRecord: return "/baseballGame"
    case .teamWinRate: return "/teamWinRate"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .realRecord: return .post
    case .teamWinRate: return .post
    }
  }
  
  var task: HTTPTask {
    switch self {
    case let .realRecord(date, myTeam):
      let parameters = ["date": date, "myTeam": myTeam]
    return .requestParameters(parameters: parameters, encoding: .jsonBody)
    
    case let .teamWinRate(myTeam):
      let parameters = ["myTeam": myTeam]
      return .requestParameters(parameters: parameters, encoding: .jsonBody)
    }
  }
}
