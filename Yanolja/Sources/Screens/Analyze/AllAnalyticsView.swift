//
//  AllAnalyticsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct AllAnalyticsView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: RecordUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  @State var selectedCell: AnalyticsFilter?
  @State var selectedAnalyticsFilter: AnalyticsFilter = .initialValue
  @State var isAscending: Bool = true
  
  var body: some View {
    let filteredRecordList = winRateUseCase.state.filteredRecordList
    let sortTeamList = winRateUseCase.state.eachTeamAnalytics.sortByWinRate(ascending: isAscending).filter { $0 != userInfoUseCase.state.myTeam }
    let sortStadiumsList = winRateUseCase.state.eachStadiumsAnalytics.sortByWinRate(ascending: isAscending)
    
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 30)
      
      TotalRecordCell(
        recordList: filteredRecordList,
        myTeam: userInfoUseCase.state.myTeam ?? .noTeam
      )
      
      Spacer()
        .frame(height: 10)
      
      HStack(spacing: 11) {
        VStack(alignment: .leading, spacing: 8) {
          Text("우리 팀 승률")
            .font(.footnote)
          HStack {
            Spacer()
            Text("\(winRateUseCase.state.myTeamWinRate?.toString ?? "--")%")
              .font(.title2)
              .bold()
          }
        }
        .padding(16)
        .background {
          RoundedRectangle(cornerRadius: 14)
            .stroke(style: StrokeStyle(lineWidth: 0.33))
            .foregroundStyle(.gray)
        }
        .clipShape(RoundedRectangle(cornerRadius: 14))
        
        VStack(alignment: .leading, spacing: 8) {
          Text("나의 직관 승률")
            .font(.footnote)
          HStack {
            Spacer()
            if let totalWinRate = filteredRecordList.winRate {
              Text("\(totalWinRate)%")
            } else {
              Text("--%")
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
        .clipShape(RoundedRectangle(cornerRadius: 14))
      }
      
      Spacer()
        .frame(height: 24)
      
      VStack(spacing: 0) {
        HStack {
          HStack(spacing: 4) {
            AnalyticsListFilterButton(selectedAnalyticsFilter: $selectedAnalyticsFilter)
            Spacer()
            RecordListOrderButton(sortByLatestDate: $isAscending)
          }
          .foregroundStyle(.gray)
        }
        .padding(.bottom, 16)
        
        ScrollView(.vertical) {
          VStack(spacing: 12) {
            switch selectedAnalyticsFilter {
            case .team:
              ForEach(sortTeamList, id: \.self.name) { vsTeam in
                Button(
                  action: {
                    selectedCell = .team(vsTeam)
                  },
                  label: {
                    WinRateGraphCell(
                      myTeamSubColor: userInfoUseCase.state.myTeam?.subColor ?? .gray,
                      detailOptionsName: vsTeam.name,
                      winRate: winRateUseCase.state.eachTeamAnalytics.vsTeamWinRate[vsTeam] ?? nil
                    )
                  }
                )
              }
            case .stadiums:
              ForEach(sortStadiumsList, id: \.self) { stadiums in
                Button(
                  action: {
                    selectedCell = .stadiums(stadiums)
                  },
                  label: {
                    WinRateGraphCell(
                      myTeamSubColor: userInfoUseCase.state.myTeam?.subColor ?? .gray,
                      detailOptionsName: stadiums,
                      winRate: winRateUseCase.state.eachStadiumsAnalytics.stadiumsWinRate[stadiums] ?? nil
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
    .navigationDestination(
      item: $selectedCell,
      destination: { selectedCell in
        AnalyticsDetailView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase,
          filterOptions: selectedCell
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(selectedCell.selectedTitle)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              self.selectedCell = nil
            }) {
              Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
            }
            .tint(.black)
          }
        }
      }
    )
  }
}

#Preview {
  AllAnalyticsView(
    winRateUseCase: WinRateUseCase(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    recordUseCase: .init(
      recordService: RecordDataService()
    ),
    userInfoUseCase: UserInfoUseCase(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService(),
      settingsService: .live
    )
  )
}
