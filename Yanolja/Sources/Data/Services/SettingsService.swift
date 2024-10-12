//
//  SettingsService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

extension SettingsService {
  static let live = {
    return Self(
      allNotices: {
        return await Provider<SettingsAPI>
          .init()
          .request(
            SettingsAPI.allNotices,
            type: [NoticesDTO].self
          )
      }
    )
  }()
}
