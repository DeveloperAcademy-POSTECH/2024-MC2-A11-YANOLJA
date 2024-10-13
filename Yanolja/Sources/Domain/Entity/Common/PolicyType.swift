//
//  PolicyType.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

public enum PolicyType {
  case termsPolicy
  case personalPolicy
  
  public var navTitle: String {
    switch self {
    case .termsPolicy:
      return "서비스 이용약관"
    case .personalPolicy:
      return "개인정보 처리방침"
    }
  }
  
  public var url: String {
    switch self {
    case .termsPolicy:
      return "http://winey-api-dev-env.eba-atefsiev.ap-northeast-2.elasticbeanstalk.com/docs/service-policy.html"
    case .personalPolicy:
      return "https://7e15b586-d215-4379-ad78-62b5afff3ca8-00-2vessprrqm1g8.sisko.replit.dev/"
    }
  }
}
