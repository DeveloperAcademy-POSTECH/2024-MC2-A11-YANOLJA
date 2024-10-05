//
//  VsTeamDetailView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - 브리
struct VsTeamDetailView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: RecordUseCase
  let detailTeam: BaseballTeam
  
  @State var winCount: Int = 0
  @State var drawCount: Int = 0
  @State var loseCount: Int = 0
  
  init(
    winRateUseCase: WinRateUseCase,
    recordUseCase: RecordUseCase,
    detailTeam: BaseballTeam
  ) {
    self.winRateUseCase = winRateUseCase
    self.recordUseCase = recordUseCase
    self.detailTeam = detailTeam
  }
  
  var body: some View {
    NavigationStack {
      VStack(spacing: 0) {
        HStack {
          Text("\(detailTeam.name)")
            .foregroundStyle(.date)
            .bold()
          Spacer()
        }
        .padding(.bottom, 8)
        
        HStack(spacing: 11) {
          VStack(alignment: .leading, spacing: 8) {
            Text("직관 승률")
              .font(.footnote)
            HStack {
              Spacer()
              if let winRate = winRateUseCase.state.myWinRate.vsTeamWinRate[detailTeam] {
                Text("\(winRate.map{ String($0) } ?? "--")")
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
            if let recordCount = winRateUseCase.state.myWinRate
              .vsTeamRecordCount[detailTeam] {
              
              Text("총 \(recordCount.map { String($0) } ?? "--")경기")
                .font(.footnote)
            } else {
              Text("총 --경기")
                .font(.footnote)
            }
            HStack {
              Spacer()
              // 각 팀의 승무패 횟수
              Text("\(winCount)승 \(loseCount)패 \(drawCount)무")
            }
            .font(.title2)
            .bold()
            .onAppear {
              teamRecordCount(recordList: recordUseCase.state.recordList)
            }
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
      
      let filteredList = recordUseCase
        .state
        .recordList
        .filter{ list in
          list.vsTeam == detailTeam
        }
      
      if filteredList.isEmpty {
        HStack{
          Spacer()
          Text("\(detailTeam.name)와의 직관 기록이 없습니다.")
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
              recordUseCase
                .state
                .recordList
                .filter{ list in
                  list.vsTeam == detailTeam
                },
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
    }
  }
  
  func teamRecordCount(recordList: [GameRecordWithScoreModel]) {
    let filteredRecordList = recordList.filter { record in
      return record.vsTeam == detailTeam && !record.isCancel
    }
    for record in filteredRecordList {
      switch record.result {
      case .win:
        winCount += 1
      case .lose:
        loseCount += 1
      case .draw:
        drawCount += 1
      }
    }
  }
}


#Preview {
  VsTeamDetailView(
    winRateUseCase: WinRateUseCase(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: RecordUseCase(recordService: RecordDataService()),
    detailTeam: .kia
  )
}
