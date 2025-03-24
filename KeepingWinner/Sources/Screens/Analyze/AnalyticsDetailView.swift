//
//  AnalyticsDetailView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AnalyticsDetailView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: AllRecordUseCase
  
  @State var selectedRecord: RecordModel?
  let selectedCategory: String
  
  init(
    winRateUseCase: WinRateUseCase,
    recordUseCase: AllRecordUseCase,
    selectedCategory: String
  ) {
    self.winRateUseCase = winRateUseCase
    self.recordUseCase = recordUseCase
    self.selectedCategory = selectedCategory
  }
  
  var body: some View {
    VStack {
      HStack(spacing: 11) {
        VStack(alignment: .leading, spacing: 8) {
          Text("직관 승률")
            .font(.footnote)
          HStack(spacing: 0) {
            Spacer()
            if let winRate = winRateUseCase.state
              .selectedGroupingOptionRecords[selectedCategory]?.winRate {
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
          let recordCount = winRateUseCase.state
            .selectedGroupingOptionRecords[selectedCategory]?.count
          Text("총 \(String(recordCount ?? 0))경기")
            .font(.footnote)
          
          HStack {
            Spacer()
            let filteredRecordList = winRateUseCase.state.selectedGroupingOptionRecords[selectedCategory] ?? []
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
      .padding(.top, 30)
      .padding(.bottom, 20)
      .padding(.horizontal, 16)
      
      let records = winRateUseCase.state
        .selectedGroupingOptionRecords[selectedCategory] ?? []
      
      if records.isEmpty {
        HStack{
          Spacer()
          Text("\(selectedCategory)와의 직관 기록이 없습니다")
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
            ForEach(records.sortByLatestDate(true),
              id: \.id
            ) { record in
              Button(
                action: {
                  selectedRecord = record
                },
                label: {
                  RecordCell(
                    record: record
                  )
                }
              )
              .sheet(
                item: $selectedRecord,
                content: { record in
                  DetailRecordView(
                    to: .edit(record),
                    editRecord: { record in winRateUseCase.effect(.editRecord(record))
                      recordUseCase.effect(.editRecord(record))
                    },
                    removeRecord: { id in
                      winRateUseCase.effect(.removeRecord(id))
                      recordUseCase.effect(.removeRecord(id))
                      
                    },
                    goBackAction: { selectedRecord = nil }
                  )
                  .navigationBarBackButtonHidden()
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
    recordUseCase: AllRecordUseCase(
      recordService: RecordDataService()),
    selectedCategory: "KIA 타이거즈"
  )
}
