//
//  UserDefaultsService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

struct UserDefaultsService: MyTeamServiceInterface {
  
  func readMyTeam() -> BaseballTeam? {
    let team: String? = UserDefaults.standard.value(forKey: "myTeam") as? String
    return BaseballTeam(rawValue: team ?? "")
  }
  
  func saveTeam(to newTeam: BaseballTeam) {
    UserDefaults.standard.set(newTeam.rawValue, forKey: "myTeam")
  }
}
