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
      
      VStack(alignment: .leading, spacing: 0) {
        Text("총 \(recordUseCase.state.recordList.count)경기")
          .font(.footnote)
        Spacer()
          .frame(height: 8)
          .frame(maxWidth: .infinity)
        HStack(spacing: 6) {
          Text("\(winRateUseCase.state.myWinCount)승")
          Text("\(winRateUseCase.state.myLoseCount)패")
          Text("\(winRateUseCase.state.myDrawCount)무")
        }
          .font(.title)
          .bold()
      }
      .padding(16)
      .background {
        RoundedRectangle(cornerRadius: 14)
          .stroke(lineWidth: 0.33)
      }
      
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
        }
      }
      
      Spacer()
        .frame(height: 24)
      
      VStack(spacing: 0) {
        HStack {
          HStack(spacing: 4) {
            Text("구단별")
            Image(systemName: "chevron.down")
          }
          
          Spacer()
          Image(systemName: "arrow.up.arrow.down")
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
