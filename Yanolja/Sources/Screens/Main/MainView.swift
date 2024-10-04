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
      WinRatePercentage(winRateUseCase: winRateUseCase)
        .foregroundColor(userInfoUseCase.state.myTeam?.mainColor)
        .padding(.top, 20)
        .padding(.bottom, 8)
      
      MainCharacterView(
        characterModel: .init(
          myTeam: userInfoUseCase.state.myTeam,
          totalWinRate: winRateUseCase.state.myWinRate.totalWinRate
        )
      )
      .frame(width: 280, height: 280)
      .padding(.bottom, 8)
      
      NameBox(userInfoUseCase: userInfoUseCase)
      
      Spacer()
    }
  }
}

private struct WinRatePercentage: View {
  @Bindable var winRateUseCase: WinRateUseCase
  
  var body: some View {
    HStack(alignment: .top, spacing: 13.5) {
      // MARK: - myWinRate에 따라 이미지 적용 / 현재 단일 이미지로 테스트
      if let totalWinRate = winRateUseCase.state.myWinRate.totalWinRate {
        Image(String(totalWinRate), bundle: .main)
      } else {
        Image(.noneWinRate)
      }
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
        Text(userInfoUseCase.state.myTeam?.name ?? "무직")
          .font(.footnote)
        Image(systemName: "sparkle")
          .resizable()
          .scaledToFit()
          .frame(height: 10)
      }
      .foregroundStyle(.gray)
      
      Text(userInfoUseCase.state.myNickname)
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
        myTeamService: UserDefaultsService()
      ),
      userInfoUseCase: .init(
        myTeamService: UserDefaultsService(), myNicknameService: UserDefaultsService(),
        changeIconService: ChangeAppIconService()
      )
    )
  }
}
