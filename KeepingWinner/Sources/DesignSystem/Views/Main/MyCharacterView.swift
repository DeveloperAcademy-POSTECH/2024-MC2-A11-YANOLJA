//
//  MyCharacterView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyCharacterView: View {
  let characterModel: CharacterModel
  
  var body: some View {
    VStack {
      ZStack {
        ZStack {
          switch characterModel.emotionByWinRate {
          case .none:
            Image(.mainCharacter0Background)
            Image(.mainCharacter0Face)
              .renderingMode(.template)
            Image(.mainCharacter0Line)
            VStack {
              Spacer()
              Image(.mainCharacter0Shadow)
            }
            .frame(height: 280)
          case .veryBad:
            Image(.mainCharacter1Background)
            Image(.mainCharacter1Face)
              .renderingMode(.template)
            Image(.mainCharacter1Line)
          case .bad:
            Image(.mainCharacter2Background)
            Image(.mainCharacter2Face)
              .renderingMode(.template)
            Image(.mainCharacter2Line)
          case .good:
            Image(.mainCharacter3Background)
            Image(.mainCharacter3Face)
              .renderingMode(.template)
            Image(.mainCharacter3Line)
          case .excellent:
            Image(.mainCharacter4Background)
            Image(.mainCharacter4Face)
              .renderingMode(.template)
            Image(.mainCharacter4Line)
          }
        }
        .foregroundColor(Color(hexString: characterModel.colorHex))
      }
    }
  }
}


#Preview {
  MyCharacterView(
    characterModel: .init(
      symbol: BaseballTeamModel.noTeam.symbol,
      colorHex: BaseballTeamModel.noTeam.colorHex(),
      totalWinRate: 100
    )
  )
}
