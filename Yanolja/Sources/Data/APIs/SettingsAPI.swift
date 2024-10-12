//
//  SettingsAPI.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

enum SettingsAPI {
  case allNotices
}

extension SettingsAPI: EndPointType {
  var baseURL: String { return .baseURL }
  
  var path: String {
    switch self {
    case .allNotices:
      return "/notices"
    }
  }
  
  var method: HTTPMethod {
    switch self {
    case .allNotices: .get
    }
  }
  
  var task: HTTPTask {
    switch self {
    case .allNotices: .requestPlain
    }
  }
}
