//
//  MainCharacterWithBubbleView.swift
//  Yanolja
//
//  Created by 유지수 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct MainCharacterWithBubbleView: View {
  @State private var isVisible: [Bool] = [false, false, false, false, false]
  @State private var isAnimating: [Bool] = [false, false, false, false, false]
  private let maxCount = 5

  let characterModel: CharacterModel
  let bubbleText: [String]
  
  var body: some View {
    VStack {
      ZStack {
        MyCharacterView(characterModel: characterModel)
        
        GeometryReader { geometry in
          ForEach(0..<bubbleText.count, id: \.self) { index in
            if isVisible[index] {
              makeBubble(text: bubbleText[index])
                .position(getPosition(for: index, in: geometry.size))
                .opacity(isAnimating[index] ? 1 : 0)
                .animation(.easeInOut(duration: 0.5), value: isAnimating[index])
            }
          }
        }
      }
    }
    .onTapGesture {
      showNextBubble()
      TrackUserActivityManager.shared.effect(.tappedMainCharacter)
    }
  }
  
  func makeBubble(text: String) -> some View {
    Text(text)
      .font(.footnote)
      .padding(.horizontal, 16)
      .padding(.vertical, 8)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .foregroundStyle(.bubble)
          .opacity(0.8)
      )
  }
  
  func showNextBubble() {
    for i in 0..<isVisible.count {
      if !isVisible[i] {
        isVisible[i] = true
        withAnimation {
          isAnimating[i] = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
          withAnimation {
            isAnimating[i] = false
          }
          
          DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isVisible[i] = false
          }
        }
        break
      }
    }
  }
  
  /// 기기의 사이즈를 고려하여 말풍선 배치
  func getPosition(for index: Int, in size: CGSize) -> CGPoint {
    switch index {
    case 0:
      return CGPoint(x: size.width * 0.23, y: size.height * 0.1)
    case 1:
      return CGPoint(x: size.width * 0.77, y: size.height * 0.53)
    case 2:
      return CGPoint(x: size.width * 0.38, y: size.height * 0.73)
    case 3:
      return CGPoint(x: size.width * 0.46, y: size.height * 0.23)
    case 4:
      return CGPoint(x: size.width * 0.65, y: size.height * 0.86)
    default:
      return CGPoint(x: size.width / 2, y: size.height / 2)
    }
  }
}
