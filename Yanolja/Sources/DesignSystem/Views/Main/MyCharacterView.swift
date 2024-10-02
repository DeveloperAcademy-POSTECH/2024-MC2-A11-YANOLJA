//
//  MyCharacterView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MainCharacterView: View {
  let characterModel: CharacterModel
  
  var body: some View {
    VStack {
      Group {
        switch characterModel.emotionByWinRate {
        case .none:
          VStack {
            Image(.mainCharacter0Line)
              .renderingMode(.template)
            Image(.shadow)
          }
        case .veryBad:
          Image(.mainCharacter1Line)
            .renderingMode(.template)
        case .bad:
          Image(.mainCharacter2Line)
            .renderingMode(.template)
        case .good:
          Image(.mainCharacter3Line)
            .renderingMode(.template)
        case .excellent:
          Image(.mainCharacter4Line)
            .renderingMode(.template)
        }
      }
      .foregroundColor(characterModel.myTeam?.mainColor ?? .none1)
    }
  }
}


#Preview {
  MainCharacterView(
    characterModel: .init(myTeam: .kiwoom, totalWinRate: 0)
  )
}

