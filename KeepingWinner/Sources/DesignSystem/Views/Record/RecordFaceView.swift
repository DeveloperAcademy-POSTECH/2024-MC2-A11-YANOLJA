//
//  RecordFaceView.swift
//  Yanolja
//
//  Created by 유지수 on 10/6/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct RecordFaceView: View {
  let characterModel: CharacterModel
  
  var body: some View {
    VStack {
      ZStack {
        switch characterModel.emotionByWinRate {
        case .none:
          Image(.recordFace0)
            .resizable()
            .renderingMode(.template)
          Image(.recordFaceLine)
            .resizable()
        case .veryBad:
          Image(.recordFace1)
            .resizable()
            .renderingMode(.template)
          Image(.recordFaceLine)
            .resizable()
        case .bad:
          Image(.recordFace2)
            .resizable()
            .renderingMode(.template)
          Image(.recordFaceLine)
            .resizable()
        case .good:
          Image(.recordFace3)
            .resizable()
            .renderingMode(.template)
          Image(.recordFaceLine)
            .resizable()
        case .excellent:
          Image(.recordFace4)
            .resizable()
            .renderingMode(.template)
          Image(.recordFaceLine)
            .resizable()
        }
      }
      .aspectRatio(1, contentMode: .fit)
      .frame(width: 120)
      .foregroundColor(Color(hexString: characterModel.colorHex))
    }

  }
}

#Preview {
  RecordFaceView(
    characterModel: .init(
      symbol: KeepingWinningRule.noTeamSymbol,
      colorHex: KeepingWinningRule.noTeamColorHex,
      totalWinRate: 100
    )
  )
}
