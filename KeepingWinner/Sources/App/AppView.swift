//
//  AppView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AppView: View {
  @ObservedObject var router = Router()
  @State var plusButtonTapped: Bool = false
  @State var cardButtonTapped: Bool = false
  
  var winRateUseCase: WinRateUseCase
  var recordUseCase: AllRecordUseCase
  var userInfoUseCase: UserInfoUseCase
  
  @State var selection: Tab = .main
  
  var body: some View {
      NavigationStack(path: $router.path) {
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
          .onAppear { TrackUserActivityManager.shared.effect(.mainTabOnAppear) }
          
          AllRecordView(
            winRateUseCase: winRateUseCase,
            userInfoUseCase: userInfoUseCase,
            recordUseCase: recordUseCase,
            plusButtonTapped: $plusButtonTapped
          )
          .tabItem {
            Image(systemName: "plus.app")
            // SFsymbol이 자동으로 .fill 처리되는 것 제어
              .environment(\.symbolVariants, .none)
            Text("기록")
          }
          .tag(Tab.record)
          
          AllAnalyticsView(
            winRateUseCase: winRateUseCase,
            recordUseCase: recordUseCase,
            userInfoUseCase: userInfoUseCase
          )
          .tag(Tab.analytics)
          .tabItem {
            Image(systemName: "chart.line.uptrend.xyaxis")
            Text("분석")
          }
        }
        .accentColor(.black)
        .navigationTitle(
          {
            switch selection {
            case .main: return "나의 직관 승률"
            case .record: return "\(recordUseCase.state.selectedYearFilter) 직관 기록"
            case .analytics: return "\(winRateUseCase.state.selectedYearFilter) 승률 분석"
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
                      action: { cardButtonTapped = true },
                      label: { Image(systemName: "square.and.arrow.down")
                        .offset(y: -2) }
                    )
                    Button(
                      action: { router.navigate(to: .settings)  },
                      label: { Image(systemName: "person") }
                    )
                  }
                case .record:
                  HStack(alignment: .top, spacing: 16) {
                    Button(
                      action: {
                        TrackUserActivityManager.shared.effect(.tappedPlusButtonToMakeRecord)
                        plusButtonTapped = true
                      },
                      label: { Image(systemName: "plus") }
                    )
                    
                    Button(
                      action: {
                        recordUseCase.effect(.presentingYearFilter(true))
                      },
                      label: { Image(systemName: "calendar") }
                    )
                  }
                case .analytics:
                  Button(
                    action: {
                      winRateUseCase.effect(.presentingYearFilter(true))
                    },
                    label: { Image(systemName: "calendar") }
                  )
                }
              }
              .tint(.black)
            }
          )
        }
        .sheet(
          isPresented: .init(
            get: { userInfoUseCase.state.myTeam != nil && userInfoUseCase.state.myNickname == nil },
            set: { _ in }),
          content: {
            NicknameChangeView(userInfoUseCase: userInfoUseCase, noNicknameUser: true)
              .presentationDetents([.fraction(0.9)])
          }
        )
        .interactiveDismissDisabled(true)
        .navigationDestination(for: Router.NavigationDestination.self) { destination in
          if destination == .settings {
            SettingsView(
              winRateUseCase: winRateUseCase,
              userInfoUseCase: userInfoUseCase
            )
            .navigationTitle("마이페이지")
            .navigationBarBackButtonHidden(true)
            .toolbar {
              ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                  router.navigateBack()
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
          isPresented: Binding<Bool>.init(
            get: { return userInfoUseCase.state.myTeam == nil },
            set: { _ in }
          ),
          content: {
            OnboardingView(
              onBoardingResultInfo: { (myTeam, nickname) in
                userInfoUseCase.effect(.changeMyTeam(myTeam))
                userInfoUseCase.effect(.changeMyNickname(nickname))
                winRateUseCase.effect(.tappedTeamChange(myTeam))
              },
              baseballTeams:
                userInfoUseCase.state.myTeamOptions
            )
          }
        )
      }
      .overlayIf(cardButtonTapped) {
        ShareCardView(
          winRateUseCase: winRateUseCase,
          userInfoUseCase: userInfoUseCase,
          characterModel: .init(
            symbol: userInfoUseCase.state.myTeam?.symbol ?? KeepingWinningRule.noTeamSymbol,
            colorHex: userInfoUseCase.state.myTeam?
              .colorHex() ?? KeepingWinningRule.noTeamColorHex,
            totalWinRate: winRateUseCase.state.recordWinRate
          ),
          cardButtonTapped: $cardButtonTapped
        )
      }
      .environmentObject(router)
  }
}

#Preview {
  AppView(
    winRateUseCase: .init(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    recordUseCase: .init(
      recordService: RecordDataService()
    ),
    userInfoUseCase: .init(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService(),
      settingsService: .preview
    )
  )
}
