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
  @State private var isBouncing = false
  
  var body: some View {
    VStack {
      BubbleTextView(
        text: characterModel.message
      )
      
      characterModel.image
        .resizable()
        .scaledToFit()
//        .offset(y: isBouncing ? -20 : 35)
//        .onAppear {
//            withAnimation(
//              Animation.easeInOut(duration: 1.4)
//                    .repeatForever(autoreverses: true)
//            ) {
//                isBouncing.toggle()
//            }
//        }
    }
  }
}

#Preview {
  MyCharacterView(
    characterModel: .init(myTeam: .kiwoom)
  )
}
