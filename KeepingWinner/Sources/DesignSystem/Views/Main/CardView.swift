//
//  CardView.swift
//  KeepingWinner
//
//  Created by 유지수 on 3/22/25.
//

import SwiftUI

struct CardView: View {
  let recordWinRate: Int?
  let myTeam: String
  let myNickname: String?
  let characterModel: CharacterModel
  
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(Color.white)
      .frame(width: 280, height: 470)
      .overlay {
        cardContent
      }
  }
  
  @ViewBuilder
  private var cardContent: some View {
    if let winRate = recordWinRate {
      HStack(spacing: 0) {
        ZStack {
          Image(.shareCardBackground)
            .renderingMode(.template)
            .foregroundColor(Color(hexString: characterModel.colorHex))
            .overlay(
              ZStack {
                VStack(spacing: 0) {
                  WinRatePercentage(totalWinRate: winRate)
                    .padding(.top, 34)
                  Spacer()
                }
                
                VStack(spacing: 0) {
                  Spacer()
                  
                  MyCharacterView(characterModel: characterModel)
                    .frame(width: 195, height: 196)
                    .padding(.bottom, 5)
                }
              }
            )
        }
        
        Line().dashed()
          .frame(width: 2)
          .padding(.leading, 13)
          .padding(.trailing, 12)
        
        VStack(spacing: 0) {
          CardNameBox(
            myTeam: myTeam,
            myNickname: myNickname
          ).rotated()
          Spacer()
        }
        .padding(.top, 16)
      }
    } else {
      Text("아직 승률을 볼 수 있는 경기가 없네요.\n우리 다음 직관을 노려봐요!")
        .font(.footnote)
        .foregroundStyle(.black.opacity(0.5))
        .multilineTextAlignment(.center)
    }
  }
}

private struct WinRatePercentage: View {
  let totalWinRate: Int?
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      Text(totalWinRate.map { "\($0)" } ?? "--")
        .jikyoFont(.cardWinRate)
        .frame(height: 220)
      
      Image(.percent)
        .renderingMode(.template)
        .frame(width: 23, height: 90)
    }
    .foregroundStyle(.white)
  }
}

struct CardNameBox: View {
  let myTeam: String
  let myNickname: String?
  
  var body: some View {
    HStack(spacing: 0) {
      Text(myTeam)
        .font(.footnote)
        .foregroundStyle(Color(.systemGray))
        .padding(.horizontal, 13)
        .padding(.vertical, 7)
        .background(
          RoundedRectangle(cornerRadius: 24)
            .stroke(lineWidth: 0.54)
            .foregroundStyle(Color(.systemGray))
        )
      
      Text(myNickname ?? "기본 이름")
        .font(.title2)
        .bold()
        .padding(.leading, 10)
    }
  }
}

#Preview {
  CardView(
    recordWinRate: 100,
    myTeam: "두산 베어스",
    myNickname: "부리부리",
    characterModel: .init(
      symbol: KeepingWinningRule.noTeamSymbol,
      colorHex: KeepingWinningRule.noTeamColorHex,
      totalWinRate: 100
    ))
}
