//
//  MainView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MainView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: RecordUseCase
  @State var selectedTeam: BaseballTeam?
  
  var body: some View {
    VStack(spacing: 30) {
      MyCharacterView(
        characterModel: .init(
          myTeam: winRateUseCase.state.myTeam,
          totalWinRate: winRateUseCase.state.myWinRate.totalWinRate
        )
      )
      .padding(.horizontal, 20)
      
      VStack(spacing: 3) {
        Text("평균 직관 승리 기여도")
          .font(.footnote)
        Text("\(winRateUseCase.state.myWinRate.totalWinRate.map{ String($0) } ?? "--")%")
          .font(.title)
          .fontWeight(.bold)
      }
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(winRateUseCase.state.myWinRate.sortedTeams, id: \.self.name) { team in
            if winRateUseCase.state.myTeam != team {
              Button(
                action: {
                  winRateUseCase.effect(.tappedTeamWinRateCell)
                  selectedTeam = team
                },
                label: {
                  // MARK: - 구름
                  MediumVsTeamCell(
                    team: team,
                    winRate: winRateUseCase.state.myWinRate.vsTeamWinRate[team] ?? nil
                  )
                }
              )
            }
          }
        }
        .padding(.horizontal, 15)
      }
      .scrollIndicators(.never)
      .sheet(
        isPresented:
          .init(
            get: {
              winRateUseCase.state.tappedTeamWinRateCell
            },
            set: { _ in
              winRateUseCase.effect(.tappedTeamWinRateCell)
            }
          ),
        content: {
          if let team = selectedTeam {
            VsTeamDetailView(
              winRateUseCase: winRateUseCase,
              recordUseCase: recordUseCase,
              detailTeam: team
            )
            .presentationDetents([.fraction(0.8)])
            .presentationDragIndicator(.visible)
          }
        }
      )
    }
  }
}

#Preview {
  MainView(
    winRateUseCase: WinRateUseCase(dataService: CoreDataService()),
    recordUseCase: RecordUseCase()
  )
}
