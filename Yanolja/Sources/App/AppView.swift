//
//  AppView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AppView: View {
  @State var selection = 0
  var winRateUseCase: WinRateUseCase = .init(dataService: CoreDataService())
  var recordUseCase: RecordUseCase = .init()
  
  var body: some View {
    NavigationStack {
      TabView(selection: $selection) {
        MainView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase
        )
        .tag(0)
        AllRecordView(useCase: recordUseCase)
        .tag(1)
      }
      .tabViewStyle(PageTabViewStyle())
      .indexViewStyle(
        PageIndexViewStyle(backgroundDisplayMode: .always)
      )
      .navigationTitle(
        selection == 0 ? "나의 직관 승률" : "나의 직관 리스트"
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
                        winRateUseCase.state.myTeam
                      },
                      set: { team in
                        winRateUseCase.effect(.requestTeamChange(team))
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
                    .foregroundStyle(winRateUseCase.state.myTeam.mainColor)
                    .overlay{
                      Text(winRateUseCase.state.myTeam.name.split(separator: " ").first ?? "")
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
