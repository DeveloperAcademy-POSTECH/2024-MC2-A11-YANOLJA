//
//  SettingsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      ContentView(
        winRateUseCase: winRateUseCase,
        userInfoUseCase: userInfoUseCase
      )
      .offset(y: -20)
      Text("승리지쿄 | ver \(BundleInfo.getVersion ?? "0.0")")
        .font(.caption)
        .foregroundStyle(.gray)
    }
    .background(Color(UIColor.systemGray6))
    .navigationBarTitleDisplayMode(.inline)
  }
}

#Preview {
  SettingsView(
    winRateUseCase: .init(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    userInfoUseCase: .init(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService(), 
      settingsService: .live
    )
  )
}

// Enum으로 각 버튼 구분
enum ActiveSheet: Identifiable {
  case teamChange, nicknameChange
  var id: Int { hashValue }
}

struct ContentView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  @State private var activeSheet: ActiveSheet?
  
  var body: some View {
    List {
      VStack(spacing: 12) {
        ZStack {
          Circle()
            .foregroundStyle(.white)
            .frame(width: 120)
          Circle()
            .stroke(lineWidth: 0.33)
            .fill(Color(.systemGray6))
            .frame(width: 120)
          ZStack {
            Image(.myPageFace)
              .resizable()
              .renderingMode(.template)
              .foregroundStyle(userInfoUseCase.state.myTeam?.mainColor ?? .noTeam1)
            Image(.myPageLine)
              .resizable()
          }
          .aspectRatio(1, contentMode: .fit)
          .frame(width: 112)
          .offset(y: 17)
        }
        .clipShape(Circle())
        
        Text("\(userInfoUseCase.state.myNickname ?? "기본 이름")")
          .font(.title2)
          .fontWeight(.black)
          .frame(maxWidth: .infinity)
      }
      .listRowBackground(Color.clear)
      
      Section(header: Text("내 정보")) {
        Button(action: {
          activeSheet = .teamChange
        }) {
          Text("팀 변경")
        }
        
        Button(action: {
          activeSheet = .nicknameChange
        }) {
          Text("닉네임 변경")
        }
      }
      
      Section(header: Text("승리지쿄 정보")) {
        NavigationLink(
          destination: {
            PolicyView(viewType: .termsPolicy)
              .navigationTitle("이용약관")
              .navigationBarTitleDisplayMode(.inline)
              .navigationBarBackButtonHidden(true)
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  BackButton()
                }
              }
          },
          label: { Text("이용약관") }
        )
        
        NavigationLink(
          destination: {
            PolicyView(viewType: .personalPolicy)
              .navigationTitle("개인정보 처리방침")
              .navigationBarTitleDisplayMode(.inline)
              .navigationBarBackButtonHidden(true)
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  BackButton()
                }
              }
          },
          label: { Text("개인정보 처리방침") }
        )
        
        NavigationLink(
          destination: {
            CreatorsView()
              .navigationTitle("승리지쿄를 만든 사람들")
              .navigationBarTitleDisplayMode(.inline)
              .navigationBarBackButtonHidden(true)
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  BackButton()
                }
              }
          },
          label: { Text("승리지쿄를 만든 사람들") }
        )
        
        NavigationLink(
          destination: {
            NoticesView(notices: userInfoUseCase.state.notices)
              .onAppear { userInfoUseCase.effect(.setNotices) }
              .navigationTitle("공지사항")
              .navigationBarTitleDisplayMode(.inline)
              .navigationBarBackButtonHidden(true)
              .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                  BackButton()
                }
              }
          },
          label: { Text("공지사항") }
        )
      }
      .navigationBarBackButtonHidden(true)
      .navigationBarTitleDisplayMode(.inline)
      .buttonStyle(PlainButtonStyle())
    }
    .listStyle(InsetGroupedListStyle())  // 그룹화된 리스트 스타일 사용
    .tint(.black)
    // sheet modifier 사용하여 시트가 활성화되면 올라오게 설정
    .sheet(item: $activeSheet) { item in
      switch item {
      case .teamChange:
        TeamChangeView(
          winRateUseCase: winRateUseCase,
          userInfoUseCase: userInfoUseCase
        )  // '팀 변경' 화면
        .presentationDetents([.fraction(0.9)])
      case .nicknameChange:
        NicknameChangeView(userInfoUseCase: userInfoUseCase)  // '닉네임 변경' 화면
          .presentationDetents([.fraction(0.9)])
      }
    }
  }
}

private struct BackButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button(action: {
      dismiss()
    }) {
      Image(systemName: "chevron.left")
        .font(.system(size: 18, weight: .semibold))
    }
    .tint(.black)
  }
}
