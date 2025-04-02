//
//  BaseballGameDTO.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

struct BaseballGameDTO: Codable {
  let date, myTeam, myTeamScore, vsTeam: String
  let vsTeamScore, result, stadium: String
  let cancel: Bool
  let cancelReason: String
  let doubleHeaderGameOrder: Int
}
