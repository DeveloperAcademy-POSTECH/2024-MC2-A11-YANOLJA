//
//  AppView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AppView: View {
  
  var body: some View {
    NavigationStack {
      TabView(selection: $selection) {
        MainView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase,
          myTeamUseCase: myTeamUseCase
        )
        .tag(0)
        AllRecordView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase
        )
        .tag(1)
      }
      .ignoresSafeArea(edges: .bottom)
      .tabViewStyle(PageTabViewStyle())
      .indexViewStyle(
        PageIndexViewStyle(backgroundDisplayMode: .always)
      )
      .navigationTitle(
        selection == 0 ? "나의 직관 승률" : "나의 직관 리스트"
      )
      .fullScreenCover(
        isPresented: .init(
          get: {
            return myTeamUseCase.state.myTeam == nil
          },
          set: { _ in }
        ),
        content: {
          MyTeamSelectView(
            completeSelectionAction: { myTeam in
              myTeamUseCase.effect(.changeMyTeam(myTeam))
              winRateUseCase.effect(.tappedTeamChange(myTeam))
            }
          )
        }
      )
      .toolbar {
        ToolbarItem(
          placement: .topBarTrailing,
          content: {
            if selection == 0 {
              Menu(
                content: {
                  Picker(
                    "나의 팀 변경",
                    selection: .init(
                      get: {
                        myTeamUseCase.state.myTeam ?? .doosan
                      },
                      set: { team in
                        myTeamUseCase.effect(.changeMyTeam(team))
                        winRateUseCase.effect(.tappedTeamChange(team))
                      }
                    )
                  ) {
                    ForEach(BaseballTeam.allCases, id: \.self) { team in
                      Text(team.name)
                    }
                  }
                  .pickerStyle(.menu)
                },
                label: {
                  Circle()
                    .frame(width: 40)
                    .foregroundStyle((myTeamUseCase.state.myTeam ?? .doosan).mainColor)
                    .overlay{
                      Text(
                        myTeamUseCase
                          .state
                          .myTeam?
                          .name
                          .split(separator: " ").first ?? ""
                      )
                      .foregroundStyle(.white)
                      .font(.callout)
                    }
                }
              )
            } else {
              Button(
                action: {
                  recordUseCase
                    .effect(.tappedCreateRecordSheet(true))
                },
                label: {
                  Image(
                    systemName: "plus"
                  )
                }
              )
            }
          }
        )
      }
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
