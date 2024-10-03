//
//  AppView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AppView: View {
  @State private var path = NavigationPath()  // 네비게이션 경로 관리
  
  var winRateUseCase: WinRateUseCase
  var recordUseCase: RecordUseCase
  var userInfoUseCase: UserInfoUseCase
  
  @State var selection: Tab = .main
  @State var selectedRecordYearFilter: String = YearFilter.initialValue
  @State var selectedAnalyzeYearFilter: String = YearFilter.initialValue
  
  var body: some View {
    NavigationStack(path: $path) {
      TabView(selection: $selection) {
        MainView(
          winRateUseCase: winRateUseCase,
          userInfoUseCase: userInfoUseCase
        )
        .tabItem {
          Image(systemName: "house")
          // SFsymbol이 자동으로 .fill 처리되는 것 제어
            .environment(\.symbolVariants, .none)
          Text("홈")
        }
        .tag(Tab.main)
        
        AllRecordView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase,
          selectedYearFilter: $selectedRecordYearFilter
        )
        .tabItem {
          Image(systemName: "plus.app")
          // SFsymbol이 자동으로 .fill 처리되는 것 제어
            .environment(\.symbolVariants, .none)
          Text("기록")
        }
        .tag(Tab.record)
        
        AllAnalyzeView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase,
          userInfoUseCase: userInfoUseCase,
          selectedYearFilter: $selectedAnalyzeYearFilter
        )
        .tag(Tab.analyze)
        .tabItem {
          Image(systemName: "chart.line.uptrend.xyaxis")
          Text("분석")
        }
      }
      .navigationTitle(
        {
          switch selection {
          case .main: return "나의 직관 승률"
          case .record: return "\(selectedRecordYearFilter) 직관 기록"
          case .analyze: return "\(selectedAnalyzeYearFilter) 직관 분석"
          }
        }()
      )
      .navigationBarTitleDisplayMode(.large)
      .toolbar {
        ToolbarItem(
          placement: .topBarTrailing,
          content: {
            Group {
              switch selection {
              case .main:
                HStack(alignment: .top, spacing: 16) {
                  Button(
                    action: { print("이미지 다운로드") },
                    label: { Image(systemName: "square.and.arrow.down")
                      .offset(y: -2) }
                  )
                  Button(
                    action: { path.append(NavigationDestination.settings) },
                    label: { Image(systemName: "gearshape") }
                  )
                }
              case .record:
                HStack(alignment: .top, spacing: 16) {
                  Button(
                    action: {
                      recordUseCase
                        .effect(.tappedCreateRecordSheet(true))
                    },
                    label: { Image(systemName: "plus") }
                  )
                  Menu {
                    ForEach(YearFilter.list, id: \.self) { selectedFilter in
                      Button(
                        action: {
                          selectedRecordYearFilter = selectedFilter
                        }
                      ) {
                        HStack {
                          if selectedRecordYearFilter == selectedFilter {
                            Image(systemName: "checkmark")
                          }
                          Text(selectedFilter)
                        }
                      }
                    }
                  } label: {
                    Image(systemName: "calendar")
                  }
                }
              case .analyze:
                Menu {
                  ForEach(YearFilter.list, id: \.self) { selectedFilter in
                    Button(
                      action: {
                        selectedAnalyzeYearFilter = selectedFilter
                      }
                    ) {
                      HStack {
                        if selectedAnalyzeYearFilter == selectedFilter {
                          Image(systemName: "checkmark")
                        }
                        Text(selectedFilter)
                      }
                    }
                  }
                } label: {
                  Image(systemName: "calendar")
                }
              }
            }
            .tint(.black)
          }
        )
      }
      .navigationDestination(for: NavigationDestination.self) { destination in
        switch destination {
        case .settings:
          SettingsView(userInfoUseCase: userInfoUseCase)
            .navigationTitle("마이페이지")
            .navigationBarBackButtonHidden(true)
            .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                  path.removeLast()
                }) {
                  Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                }
                .tint(.black)
              }
            }
        }
      }
      .fullScreenCover(
        isPresented: .init(
          get: {
            return userInfoUseCase.state.myTeam == nil
          },
          set: { _ in }
        ),
        content: {
          OnboardingView(
            onBoardingResultInfo: { (myTeam, nickname) in
              userInfoUseCase.effect(.changeMyTeam(myTeam))
              userInfoUseCase.effect(.changeMyNickname(nickname))
              winRateUseCase.effect(.tappedTeamChange(myTeam))
            }
          )
        }
      )
    }
  }
}

#Preview {
  AppView(
    winRateUseCase: .init(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: .init(
      recordService: RecordDataService()
    ),
    userInfoUseCase: .init(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService()
    )
  )
}
