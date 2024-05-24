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
  @Bindable var myTeamUseCase: MyTeamUseCase
  @State var selectedTeam: BaseballTeam?
  
  var body: some View {
    VStack(spacing: 0) {
      MyCharacterView(
        characterModel: .init(
          myTeam: myTeamUseCase.state.myTeam ?? .doosan,
          totalWinRate: winRateUseCase.state.myWinRate.totalWinRate
        )
      )
      .padding(.top, 25)
      .padding(.horizontal, 30)
      
      Spacer()
      
      VStack(spacing: 3) {
        Text("평균 직관 승리 기여도")
          .font(.footnote)
        Text("\(winRateUseCase.state.myWinRate.totalWinRate.map{ String($0) } ?? "--")%")
          .font(.title)
          .fontWeight(.bold)
      }
      
      Spacer()
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(winRateUseCase.state.myWinRate.sortedTeams, id: \.self.name) { team in
            if myTeamUseCase.state.myTeam != team {
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
    .padding(.bottom, 40)
  }
}

#Preview {
  MainView(
    winRateUseCase: WinRateUseCase(
      dataService: CoreDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: RecordUseCase(dataService: CoreDataService()),
    myTeamUseCase: .init(
      myTeamService: UserDefaultsService(),
      changeIconService: ChangeAppIconService()
    )
  )
}
