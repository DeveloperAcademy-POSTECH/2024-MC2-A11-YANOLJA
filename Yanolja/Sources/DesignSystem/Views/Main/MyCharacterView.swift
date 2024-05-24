//
//  MyCharacterView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct ShakingImageView: View {
  @State private var isShaking = false
  @State private var timer: Timer?
  var image: Image
  
  var body: some View {
    image
      .resizable()
      .scaledToFit()
      .aspectRatio(contentMode: .fit)
      .offset(x: isShaking ? -10 : 0)
      .animation(isShaking ?
                 Animation.linear(duration: 0.05).repeatForever(autoreverses: true) :
          .default, value: isShaking)
      .onAppear {
        startShaking()
      }
      .onDisappear {
        stopShaking()
      }
  }
  
  private func startShaking() {
    timer = Timer.scheduledTimer(withTimeInterval: 1.3, repeats: true) { _ in
      withAnimation {
        isShaking.toggle()
      }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        withAnimation {
          isShaking.toggle()
        }
      }
    }
  }
  
  private func stopShaking() {
    timer?.invalidate()
    timer = nil
  }
}

struct BouncingImageView: View {
  @State private var isBouncing = false
  var image: Image
  
  var body: some View {
    image
      .resizable()
      .scaledToFit()
      .aspectRatio(contentMode: .fit)
      .offset(y: isBouncing ? -20 : 35)
      .animation(
        Animation.easeInOut(duration: 1.4)
          .repeatForever(autoreverses: true),
        value: isBouncing
      )
      .onAppear {
        withAnimation {
          isBouncing.toggle()
        }
      }
  }
}

struct ScalingImageView: View {
  @State private var isScaled = false
  var image: Image
  
  var body: some View {
    image
      .resizable()
      .scaledToFit()
      .scaleEffect(isScaled ? 1.07 : 1.0)
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 1.4).repeatForever(autoreverses: true)) {
          isScaled.toggle()
        }
      }
  }
}

struct HappyImageView: View {
  @State private var isHappy = false
  var image: Image
  
  var body: some View {
    image
      .resizable()
      .scaledToFit()
      .rotationEffect(.degrees(isHappy ? 15 : -15))
      .scaleEffect(isHappy ? 1.08 : 1.0)
      .onAppear {
        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
          isHappy.toggle()
        }
      }
  }
}

struct MyCharacterView: View {
  let characterModel: CharacterModel
  
  var body: some View {
    VStack {
      BubbleTextView(
        text: characterModel.message
      )
      
      if characterModel.emotionByWinRate == .veryBad {
        ScalingImageView(image: characterModel.image)
      } else if characterModel.emotionByWinRate == .bad {
        ShakingImageView(image: characterModel.image)
      } else if characterModel.emotionByWinRate == .excellent {
        HappyImageView(image: characterModel.image)
      } else {
        BouncingImageView(image: characterModel.image)
      }
    }
  }
}


#Preview {
  MyCharacterView(
    characterModel: .init(myTeam: .kiwoom, totalWinRate: 50)
  )
}

