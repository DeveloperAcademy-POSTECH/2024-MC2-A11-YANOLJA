//
//  AllAnalyzeView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct AllAnalyzeView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: RecordUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  @State var selectedTeam: BaseballTeam?
  
  @Binding var selectedYearFilter: String // 년도 별 필터 기준
  
  var body: some View {
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 30)
      
      TotalRecordCell(winRateUseCase: winRateUseCase, recordUseCase: recordUseCase)
      
      Spacer()
        .frame(height: 10)
      
      HStack(spacing: 11) {
        VStack(alignment: .leading, spacing: 8) {
          Text("우리 팀 승률")
            .font(.footnote)
          HStack {
            Spacer()
            Text("에디%")
              .font(.title2)
              .bold()
          }
        }
        .padding(16)
        .background {
          RoundedRectangle(cornerRadius: 14)
            .stroke(lineWidth: 0.33)
            .foregroundStyle(.gray)
        }
        
        VStack(alignment: .leading, spacing: 8) {
          Text("나의 승률")
            .font(.footnote)
          HStack {
            Spacer()
            if let totalWinRate = winRateUseCase.state.myWinRate.totalWinRate {
              Text("\(totalWinRate)%")
            } else {
              if let totalWinRate = winRateUseCase.state.myWinRate.totalWinRate {
                Text("\(totalWinRate)%")
              } else {
                Text("--%")
              }
            }
          }
          .font(.title2)
          .bold()
        }
        .padding(16)
        .background {
          RoundedRectangle(cornerRadius: 14)
            .stroke(lineWidth: 0.33)
            .foregroundStyle(.gray)
        }
      }
      
      Spacer()
        .frame(height: 24)
      
      VStack(spacing: 0) {
        HStack {
          HStack(spacing: 4) {
            Text("구단별")
              .font(.subheadline)
              .bold()
            Image(systemName: "chevron.down")
              .font(.subheadline)
              .bold()
          }
          .foregroundStyle(.gray)
          
          Spacer()
          Image(systemName: "arrow.up.arrow.down")
            .font(.subheadline)
            .bold()
            .foregroundStyle(.gray)
        }
        .padding(.bottom, 16)
        
        ScrollView(.vertical) {
        VStack(spacing: 12) {
          ForEach(winRateUseCase.state.myWinRate.sortedTeams, id: \.self.name) { vsTeam in
            if userInfoUseCase.state.myTeam != vsTeam {
              Button(
                action: {
                  winRateUseCase.effect(.tappedTeamWinRateCell)
                  selectedTeam = vsTeam
                },
                label: {
                  WinRateGraphCell(
                    myTeam: winRateUseCase.state.myTeam,
                    vsTeam: vsTeam,
                    winRate: winRateUseCase.state.myWinRate.vsTeamWinRate[vsTeam] ?? nil
                  )
                }
              )
            }
          }
        }
      }
      }
    }
    .padding(.horizontal, 16)
    .navigationBarTitleDisplayMode(.large)
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

#Preview {
  AllAnalyzeView(
    winRateUseCase: WinRateUseCase(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: .init(
      recordService: RecordDataService()
    ),
    userInfoUseCase: UserInfoUseCase(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService()
    ), 
    selectedYearFilter: .constant("전체")
  )
}
