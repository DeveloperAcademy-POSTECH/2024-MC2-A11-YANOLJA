//
//  OnboardingView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
  let onBoardingResultInfo: (BaseballTeam, String) -> Void
  
  @State var selectedTeam: BaseballTeam? = nil
  @State var selectedUserNickname: String = ""
  @State var tappedSelectedTeamConfirm: Bool = false
  
  var body: some View {
    NavigationStack {
      HStack{
        Text("나의 팀을 \n선택해 주세요")
          .font(.system(.largeTitle, weight: .bold))
        Spacer()
      }
      .padding(.leading, 16)
      .padding(.top, 20)
      
      VStack(spacing: 0) {
        MyTeamSettingsContentView(selectedTeam: $selectedTeam)
        
        Spacer()
        
        Button(
          action: {
            tappedSelectedTeamConfirm = true
          },
          label: {
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .foregroundColor(selectedTeam != nil ? .black : .gray)
                .frame(height: 48)
              Text("다음으로")
                .foregroundColor(.white)
                .font(.system(.headline, weight: .bold))
            }
          }
        )
        .disabled(selectedTeam == nil)
        .padding(.horizontal, 16)
      }
      .navigationDestination(
        isPresented: $tappedSelectedTeamConfirm,
        destination: {
          VStack(spacing: 0) {
            HStack {
              Text("나의 닉네임을 \n선택해 주세요")
                .font(.system(.largeTitle, weight: .bold))
              Spacer()
            }
            .padding(.top, 3)
            
            NicknameSettingsContentView(inputText: $selectedUserNickname)
              .padding(.top, 28)
            
            Spacer()
            
            Button(
              action: {
                // MARK: - 메인 화면으로 이동
                if let selectedTeam, selectedUserNickname != "" {
                  onBoardingResultInfo(selectedTeam, selectedUserNickname)
                }
              },
              label: {
                ZStack {
                  RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(selectedUserNickname.isEmpty ? .gray : .black)
                    .frame(height: 48)
                  Text("시작하기")
                    .foregroundColor(.white)
                    .font(.system(.headline, weight: .bold))
                }
              }
            )
            .disabled(selectedUserNickname.isEmpty)
          }
          .padding(.horizontal, 16)
          .navigationBarBackButtonHidden(true)
          .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
              Button(action: {
                tappedSelectedTeamConfirm = false
              }) {
                Image(systemName: "chevron.left")
                  .font(.system(size: 18, weight: .semibold))
              }
              .tint(.black)
            }
          }
        }
      )
    }
  }
}


// MARK: - 실제 화면
#Preview {
  OnboardingView(
    onBoardingResultInfo: { (_, _) in }
  )
}

// MARK: - 캐릭터 선택 이후, 닉네임 변경 화면
#Preview {
  OnboardingView(
    onBoardingResultInfo: { (_, _) in },
    tappedSelectedTeamConfirm: true
  )
}
