//
//  MyNicknameServiceInterface.swift
//  Yanolja
//
//  Created by 박혜운 on 9/30/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

protocol MyNicknameServiceInterface {
  func readMyNickname() -> String?
  func saveNickname(to nickname: String)
}
