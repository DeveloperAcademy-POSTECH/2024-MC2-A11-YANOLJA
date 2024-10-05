//
//  SettingsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      ContentView(userInfoUseCase: userInfoUseCase)
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
  SettingsView(userInfoUseCase: .init(
    myTeamService: UserDefaultsService(),
    myNicknameService: UserDefaultsService(),
    changeIconService: ChangeAppIconService())
  )
}

// Enum으로 각 버튼 구분
enum ActiveSheet: Identifiable {
  case teamChange, nicknameChange, terms, privacyPolicy, creators, announcements
  
  var id: Int {
    hashValue
  }
}

struct ContentView: View {
  @State private var activeSheet: ActiveSheet?
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  var body: some View {
    List {
      VStack(spacing: 12) {
        ZStack {
          Circle()
            .stroke(lineWidth: 1)
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
        
        Text("\(userInfoUseCase.state.myNickname)")
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
      
      Section(header: Text("승리지교 정보")) {
        Button(action: {
          activeSheet = .terms
        }) {
          Text("이용약관")
        }
        
        Button(action: {
          activeSheet = .privacyPolicy
        }) {
          Text("개인정보 처리방침")
        }
        
        Button(action: {
          activeSheet = .creators
        }) {
          Text("승리지교를 만든 사람들")
        }
        
        Button(action: {
          activeSheet = .announcements
        }) {
          Text("공지사항")
        }
      }
    }
    .listStyle(InsetGroupedListStyle())  // 그룹화된 리스트 스타일 사용
    .tint(.black)
    // sheet modifier 사용하여 시트가 활성화되면 올라오게 설정
    .sheet(item: $activeSheet) { item in
      switch item {
      case .teamChange:
        TeamChangeView(userInfoUseCase: userInfoUseCase)  // '팀 변경' 화면
          .presentationDetents([.fraction(0.9)])
      case .nicknameChange:
        NicknameChangeView(userInfoUseCase: userInfoUseCase)  // '닉네임 변경' 화면
          .presentationDetents([.fraction(0.9)])
      case .terms:
        TermsView()  // '이용약관' 화면
      case .privacyPolicy:
        PrivacyPolicyView()  // '개인정보 처리방침' 화면
      case .creators:
        CreatorsView()  // '승리지교를 만든 사람들' 화면
      case .announcements:
        AnnouncementsView()  // '공지사항' 화면
      }
    }
  }
}

// 각 시트에 대한 뷰들 (여기서는 Placeholder로 간단히 정의)
struct TeamChangeView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable var userInfoUseCase: UserInfoUseCase
  @State var selectedTeam: BaseballTeam? = nil
  
  var body: some View {
    HStack(spacing: 0) {
      Button(action: {
        dismiss()
      }) {
        Text("취소")
      }
      Spacer()
      Text("팀 변경")
        .bold()
      Spacer()
      Button(action: {
        if let myTeam = selectedTeam {
          userInfoUseCase.effect(.changeMyTeam(myTeam))
        }
        dismiss()
      }) {
        Text("완료")
          .bold()
      }
    }
    .frame(height: 44)
    .padding(.top, 16)
    .padding(.horizontal, 16)
    VStack(spacing: 0) {
      MyTeamSettingsContent(selectedTeam: $selectedTeam)
        .presentationDragIndicator(.visible)
        .onAppear {
          selectedTeam = userInfoUseCase.state.myTeam
        }
      Spacer()
    }
  }
}

struct NicknameChangeView: View {
  @Environment(\.dismiss) var dismiss
  @Bindable var userInfoUseCase: UserInfoUseCase
  @State var selectedUserNickname: String = ""
  
  var body: some View {
    VStack(spacing: 0) {
      HStack(spacing: 0) {
        Button(action: {
          dismiss()
        }) {
          Text("취소")
        }
        Spacer()
        Text("닉네임 변경")
          .bold()
        Spacer()
        Button(action: {
          userInfoUseCase.effect(.changeMyNickname(selectedUserNickname))
          dismiss()
        }) {
          Text("완료")
            .bold()
        }
      }
      .frame(height: 44)
      .padding(.top, 16)
      .padding(.bottom, 20)
      
      // 지정한 닉네임이 없으면 그대로 실행
      if userInfoUseCase.state.myNickname.isEmpty {
        NicknameSettingsContent(inputText: $selectedUserNickname)
          .presentationDragIndicator(.visible)
      } else {
        // 지정한 닉네임이 있다면 사용하던 닉네임이 보인다
        NicknameSettingsContent(inputText: $selectedUserNickname)
          .onAppear {
            selectedUserNickname = userInfoUseCase.state.myNickname
          }
          .presentationDragIndicator(.visible)
      }
      Spacer()
    }
    .padding(.horizontal, 16)
  }
}

struct TermsView: View {
  var body: some View {
    Text("이용약관 화면")
  }
}

struct PrivacyPolicyView: View {
  var body: some View {
    Text("개인정보 처리방침 화면")
  }
}

struct CreatorsView: View {
  var body: some View {
    Text("승리지교를 만든 사람들 화면")
  }
}

struct AnnouncementsView: View {
  var body: some View {
    Text("공지사항 화면")
  }
}
