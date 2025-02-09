//
//  SettingsServiceInterface.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

struct SettingsService {
  var characterBubbleTexts: (_ myTeam: String) async -> Result<[String], Error>
  var allStadiums: () async -> Result<[String], Error>
  var allNotices: () async -> Result<[NoticeModel], Error>
}
