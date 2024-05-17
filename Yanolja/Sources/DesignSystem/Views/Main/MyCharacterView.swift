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
      BubbleTextView(
        text: characterModel.message
      )
      
      characterModel.image
        .resizable()
        .scaledToFit()
    }
  }
}

#Preview {
  MyCharacterView(
    characterModel: .init(myTeam: .kiwoom)
  )
}
