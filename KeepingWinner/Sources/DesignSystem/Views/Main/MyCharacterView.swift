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
              .resizable()
            Image(.mainCharacter0Face)
              .resizable()
              .renderingMode(.template)
            Image(.mainCharacter0Line)
              .resizable()
            VStack {
              Spacer()
              Image(.mainCharacter0Shadow)
                .resizable()
            }
            .frame(height: 280)
          case .veryBad:
            Image(.mainCharacter1Background)
              .resizable()
            Image(.mainCharacter1Face)
              .resizable()
              .renderingMode(.template)
            Image(.mainCharacter1Line)
              .resizable()
          case .bad:
            Image(.mainCharacter2Background)
              .resizable()
            Image(.mainCharacter2Face)
              .resizable()
              .renderingMode(.template)
            Image(.mainCharacter2Line)
              .resizable()
          case .good:
            Image(.mainCharacter3Background)
              .resizable()
            Image(.mainCharacter3Face)
              .resizable()
              .renderingMode(.template)
            Image(.mainCharacter3Line)
              .resizable()
          case .excellent:
            Image(.mainCharacter4Background)
              .resizable()
            Image(.mainCharacter4Face)
              .resizable()
              .renderingMode(.template)
            Image(.mainCharacter4Line)
              .resizable()
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
      symbol: KeepingWinningRule.noTeamSymbol,
      colorHex: KeepingWinningRule.noTeamColorHex,
      totalWinRate: 100
    )
  )
}
