//
//  AnalyticsDetailView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - 브리
struct AnalyticsDetailView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: RecordUseCase
  
  let filterOptionsCategory: AnalyticsFilter
  
  var detailOptions: String {
    switch filterOptionsCategory {
    case let .team(baseballTeam):
      return baseballTeam.name
    case let .stadiums(stadiums):
      return stadiums
    }
  }
  
  var winRate: Int? {
    switch filterOptionsCategory {
    case let .team(baseballTeam):
      return winRateUseCase.state.eachTeamAnalytics.vsTeamWinRate[baseballTeam] ?? nil
    case let .stadiums(stadiums):
      return winRateUseCase.state.eachStadiumsAnalytics.stadiumsWinRate[stadiums] ?? nil
    }
  }
  
  var recordCount: Int? {
    switch filterOptionsCategory {
    case let .team(baseballTeam):
      return winRateUseCase.state.eachTeamAnalytics.vsTeamRecordCount[baseballTeam] ?? nil
    case let .stadiums(stadiums):
      return winRateUseCase.state.eachStadiumsAnalytics.stadiumsRecordCount[stadiums] ?? nil
    }
  }
  
  var filteredRecordList: [GameRecordWithScoreModel] {
    switch filterOptionsCategory {
    case let .team(baseballTeam):
      return winRateUseCase.state.filteredRecordList.filter { $0.vsTeam == baseballTeam }
    case let .stadiums(stadiums):
      return winRateUseCase.state.filteredRecordList.filter { $0.stadiums == stadiums }
    }
  }
  
  init(
    winRateUseCase: WinRateUseCase,
    recordUseCase: RecordUseCase,
    filterOptions: AnalyticsFilter
  ) {
    self.winRateUseCase = winRateUseCase
    self.recordUseCase = recordUseCase
    self.filterOptionsCategory = filterOptions
  }
  
  var body: some View {
    VStack {
      VStack(spacing: 0) {
        HStack {
          Text("\(detailOptions)")
            .foregroundStyle(.date)
            .bold()
          Spacer()
        }
        .padding(.bottom, 8)
        
        HStack(spacing: 11) {
          VStack(alignment: .leading, spacing: 8) {
            Text("직관 승률")
              .font(.footnote)
            HStack(spacing: 0) {
              Spacer()
              if let winRate {
                Text("\(String(winRate))")
                  .font(.title2)
                  .bold()
                
              } else {
                Text("--")
                  .font(.title2)
                  .bold()
              }
              Text("%")
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
            
            Text("총 \(String(recordCount ?? 0))경기")
              .font(.footnote)
            
            HStack {
              Spacer()
              // 각 팀의 승무패 횟수
              let winCount = filteredRecordList.filter { $0.result == .win }.count
              let loseCount = filteredRecordList.filter { $0.result == .lose }.count
              let drawCount = filteredRecordList.filter { $0.result == .draw }.count
              Text("\(winCount)승 \(loseCount)패 \(drawCount)무")
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
      }
      .padding(.top, 30)
      .padding(.bottom, 20)
      .padding(.horizontal, 16)
      
      if filteredRecordList.isEmpty {
        HStack{
          Spacer()
          Text("\(detailOptions)와의 직관 기록이 없습니다")
            .foregroundColor(.gray)
            .font(.callout)
            .padding(.bottom, 12)
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
      } else {
        ScrollView() {
          VStack {
            ForEach(
              filteredRecordList,
              id: \.id
            ) { record in
              NavigationLink(
                destination: {
                  DetailRecordView(
                    to: .edit,
                    record: record,
                    usecase: recordUseCase,
                    changeRecords: { updateRecords in
                      winRateUseCase.effect(.updateRecords(updateRecords)
                      )
                    }
                  )
                  .navigationBarBackButtonHidden()
                },
                label: {
                  RecordCell(record: record)
                }
              )
            }
            Spacer()
          }
          .padding(.horizontal, 16)
        }
      }
    
      Spacer()
    }
  }
}


#Preview {
  AnalyticsDetailView(
    winRateUseCase: WinRateUseCase(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    recordUseCase: RecordUseCase(
      recordService: RecordDataService()),
    filterOptions: .team(.kia)
  )
}
