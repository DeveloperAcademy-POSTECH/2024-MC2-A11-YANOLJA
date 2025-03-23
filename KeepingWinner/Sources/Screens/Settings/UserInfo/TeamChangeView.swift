//
//  TeamChangeView.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

// 각 시트에 대한 뷰들 (여기서는 Placeholder로 간단히 정의)
struct TeamChangeView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  @State var selectedTeam: BaseballTeamModel? = nil
  
  var body: some View {
    HStack(spacing: 0) {
      Button(action: {
        dismiss()
      }) {
        Text("취소")
          .tint(.black)
      }
      Spacer()
      Text("팀 변경")
        .bold()
      Spacer()
      Button(action: {
        if let myTeam = selectedTeam {
          userInfoUseCase.effect(.changeMyTeam(myTeam))
          winRateUseCase.effect(.tappedTeamChange(myTeam))
        }
        dismiss()
      }) {
        Text("완료")
          .bold()
          .tint(.black)
      }
    }
    .frame(height: 44)
    .padding(.top, 16)
    .padding(.horizontal, 16)
    
    VStack(spacing: 0) {
      MyTeamSettingsContent(
        baseballTeams: userInfoUseCase.state.myTeamOptions,
        selectedTeam: $selectedTeam
      )
        .presentationDragIndicator(.visible)
        .onAppear {
          selectedTeam = userInfoUseCase.state.myTeam
        }
      Spacer()
    }
  }
}
