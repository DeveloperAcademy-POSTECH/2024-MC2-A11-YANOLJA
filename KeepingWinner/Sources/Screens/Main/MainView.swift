//
//  MainView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MainView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
      
      WinRatePercentage(
        totalWinRate: winRateUseCase.state.recordWinRate,
        teamColor: userInfoUseCase.state.myTeam?
          .color() ?? BaseballTeamModel.noTeam.color()
      )
      .foregroundColor(
        userInfoUseCase.state.myTeam?
          .color() ?? BaseballTeamModel.noTeam
          .color()
      )
      .padding(.bottom, 8)
      
      MainCharacterWithBubbleView(
        characterModel: .init(
          symbol: userInfoUseCase.state.myTeam?.symbol ?? BaseballTeamModel.noTeam.symbol,
          colorHex: userInfoUseCase.state.myTeam?
            .colorHex() ?? BaseballTeamModel.noTeam.colorHex(),
          totalWinRate: winRateUseCase.state.recordWinRate
        ),
        bubbleText: userInfoUseCase.state.bubbleTextList
      )
      .frame(width: 280, height: 280)
      .padding(.bottom, 8)
      
      NameBox(userInfoUseCase: userInfoUseCase)
      
      Spacer()
    }
  }
}

private struct WinRatePercentage: View {
  let totalWinRate: Int?
  let teamColor: Color
  
  var body: some View {
    HStack(alignment: .top, spacing: 13.5) {
      Group {
        if let totalWinRate {
          Image(String(totalWinRate), bundle: .main)
            .renderingMode(.template)
        } else {
          Image(.noneWinRate)
            .renderingMode(.template)
        }
      }
      .foregroundStyle(teamColor)
    }
  }
}

private struct NameBox: View {
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  var body: some View {
    VStack(spacing: 8) {
      HStack(spacing: 4) {
        Image(systemName: "sparkle")
          .resizable()
          .scaledToFit()
          .frame(height: 10)
        Text(
          userInfoUseCase.state.myTeam?.name() ?? KeepingWinningRule.noTeamName
        )
          .font(.footnote)
        Image(systemName: "sparkle")
          .resizable()
          .scaledToFit()
          .frame(height: 10)
      }
      .foregroundStyle(.gray)
      
      Text(userInfoUseCase.state.myNickname ?? "기본 이름")
        .font(.title2)
        .bold()
    }
  }
}

#Preview {
  NavigationStack {
    MainView(
      winRateUseCase: WinRateUseCase(
        recordService: RecordDataService(),
        myTeamService: UserDefaultsService(),
        gameRecordInfoService: .live
      ),
      userInfoUseCase: .init(
        myTeamService: UserDefaultsService(), myNicknameService: UserDefaultsService(),
        changeIconService: ChangeAppIconService(),
        settingsService: .preview
      )
    )
  }
}
