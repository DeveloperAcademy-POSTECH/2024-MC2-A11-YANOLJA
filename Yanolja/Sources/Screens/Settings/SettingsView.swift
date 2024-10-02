//
//  SettingsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    VStack(spacing: 0) {
      ContentView()
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
  SettingsView()
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
  
  var body: some View {
    List {
      VStack(spacing: 12) {
        Circle()
          .stroke(lineWidth: 1)
          .frame(width: 120)
        Text("닉네임")
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
        TeamChangeView()  // '팀 변경' 화면
      case .nicknameChange:
        NicknameChangeView()  // '닉네임 변경' 화면
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
  var body: some View {
    Text("팀 변경 화면")
  }
}

struct NicknameChangeView: View {
  var body: some View {
    Text("닉네임 변경 화면")
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
