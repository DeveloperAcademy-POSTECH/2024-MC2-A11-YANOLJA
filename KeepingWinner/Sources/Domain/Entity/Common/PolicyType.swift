//
//  PolicyType.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

public enum PolicyType: String {
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
}
