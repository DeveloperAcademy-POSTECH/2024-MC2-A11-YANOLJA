//
//  ChangeAppIconService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/23/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import UIKit

struct ChangeAppIconService: ChangeAppIconInterface {
  func requestChangeAppIcon(to team: BaseballTeam) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
      self.changeICon(iconName: team.rawValue.uppercased())
    }
  }
}

extension ChangeAppIconService {
  func changeICon(iconName: String) {
    // 1. 필수 체크 (멀티 icon 지원여부 체크), 현재 변경하려는 아이콘과 같은지 체크
    guard UIApplication.shared.supportsAlternateIcons,
          iconName != UIApplication.shared.alternateIconName 
    else { return }
    // 2. 변경하기
    UIApplication.shared.setAlternateIconName(iconName) { iconChangeError in
      if let error = iconChangeError {
        print(error.localizedDescription)
      } else {
      }
    }
  }
}
