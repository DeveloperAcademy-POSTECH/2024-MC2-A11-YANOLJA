//
//  NoticesModel.swift
//  Yanolja
//
//  Created by 이연정 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

struct NoticeModel: Identifiable {
  let id: UUID = .init()
  let date, title, contents: String
}
