//
//  UserDefaultsService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

struct UserDefaultsService {
  func save<T>(data: T, key: UserDefaultsKeys) {
    UserDefaults.standard.set(data, forKey: key.rawValue)
  }
  
  func load<T>(type: T.Type, key: UserDefaultsKeys) -> T? {
    let data = UserDefaults.standard.value(forKey: key.rawValue) as? T
    return data
  }
}

extension UserDefaultsService: MyTeamServiceInterface {
  func readMyTeam() -> BaseballTeam? {
    let team = self.load(type: String.self, key: .myTeam)
    return BaseballTeam(rawValue: team ?? "")
  }
  
  func saveTeam(to newTeam: BaseballTeam) {
    self.save(data: newTeam.rawValue, key: .myTeam)
  }
}

extension UserDefaultsService: MyNicknameServiceInterface {
  func readMyNickname() -> String? {
    return self.load(type: String.self, key: .myNickname)
  }
  
  func saveNickname(to nickname: String) {
    self.save(data: nickname, key: .myNickname)
  }
}

enum UserDefaultsKeys: String {
  case myTeam
  case myNickname
  case isPopGestureEnabled
}
