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
  
  @State private var isVisible: [Bool] = [false, false, false, false, false]
  @State private var isAnimating: [Bool] = [false, false, false, false, false]
  private let maxCount = 5
  
  // 확인을 위한 예시
  private let bubbleText: [String] = ["최 강 두 산", "두산의 승리를 위하여 🎶", "우리가 왔어 허슬두", "두산 그대의 이름은 승리", "해냈다 해냈어 두산이 해냈어"]
  
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
        .foregroundColor(characterModel.myTeam.mainColor)
        
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


#Preview {
  MainCharacterView(
    characterModel: .init(myTeam: .kiwoom, totalWinRate: 100)
  )
}

