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
      BubbleTextView(text: "직관을 기록하고 나의 승리 기여도를 확인하세요")
      
      Circle()
        .overlay {
          Text("^-^")
            .foregroundStyle(.white)
        }
        .frame(width: 300)
      
      VStack(spacing: 3) {
        Text("평균 직관 승리 기여도")
          .font(.footnote)
        Text("\(winRateUseCase.state.myWinRate.totalWinRate.map{ String($0) } ?? "--")%")
          .font(.title)
          .fontWeight(.bold)
      }
      
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          
          ForEach(BaseballTeam.allCases, id: \.self.name) { team in
            Button(
              action: {
                winRateUseCase.effect(.tappedTeamWinRateCell
                )
                selectedTeam = team
              },
              label: {
                // MARK: - 구름
                MediumVsTeamCell(team: team)
              }
            )
          }
        }
        .padding(.horizontal, 15)
      }
      .sheet(
        isPresented:
          .init(
            get: {
              winRateUseCase.state.tappedTeamWinRateCell
            },
            set: { _ in
              winRateUseCase.effect(.tappedTeamWinRateCell
              )
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
