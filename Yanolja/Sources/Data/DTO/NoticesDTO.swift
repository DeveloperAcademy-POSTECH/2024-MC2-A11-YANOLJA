//
//  NoticesDTO.swift
//  Yanolja
//
//  Created by 박혜운 on 10/12/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

// MARK: - NoticesDTO
struct NoticesDTO: Codable {
  let notices: [Notice]
}

// MARK: - Notice
struct Notice: Codable {
  let date, noticeName, noticeComment: String
  
  enum CodingKeys: String, CodingKey {
    case date
    case noticeName = "notice_name"
    case noticeComment = "notice_comment"
  }
}
