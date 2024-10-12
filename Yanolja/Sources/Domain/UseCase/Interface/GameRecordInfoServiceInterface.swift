//
//  TeamInfoServiceInterface.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

struct GameRecordInfoService {
  var gameRecord: (_ date: Date, _ myTeam: String) async -> Result<[GameRecordWithScoreModel], Error>
  var teamWinRate: (_ myTeam: String) async -> Result<Int?, Error>
}
