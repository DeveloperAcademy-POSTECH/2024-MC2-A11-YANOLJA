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
  var winRateUseCase: WinRateUseCase = .init()
  var historyUseCase: HistoryUseCase = .init()
  
  var body: some View {
    NavigationStack {
      TabView(selection: $selection) {
        MainView(usecase: winRateUseCase)
          .tag(0)
        ListHistoryView(usecase: historyUseCase)
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
              Circle()
                .frame(width: 40)
                .overlay{
                  Text(winRateUseCase.state.myTeam.name.split(separator: " ").first ?? "")
                    .foregroundStyle(.white)
                    .font(.callout)
                }
                .contextMenu {
                  ForEach(BaseballTeam.allCases, id: \.name) { team in
                    Button {
                      winRateUseCase.effect(.requestTeamChange(team))
                    } label: {
                      if team == BaseballTeam.myTeam {
                        Label(
                          team.name,
                          systemImage: "heart"
                        )
                      } else {
                        Text(team.name)
                      }
                    }
                  }
                }
            } else {
              Button(
                action: {
                  historyUseCase
                    .effect(.tappedAddButton)
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
