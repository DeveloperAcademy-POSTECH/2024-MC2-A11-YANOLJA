//
//  MyTeamServiceInterface.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

protocol MyTeamServiceInterface {
  func readMyTeam() -> BaseballTeam?
  func saveTeam(to newTeam: BaseballTeam)
}

extension MyTeamServiceInterface {
  static func deleteMyTeam() {
    UserDefaults.standard.removeObject(forKey: "myTeam")
  }
}
