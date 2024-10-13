//
//  AllRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AllRecordView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  @Bindable var recordUseCase: RecordUseCase
  @State var selectedRecord: GameRecordWithScoreModel?
  
  @Binding var selectedYearFilter: String
  @State var selectedRecordFilter: RecordFilter = RecordFilter.initialValue
  @State var isAscending: Bool = true
  
  var body: some View {
    let filteredList = recordUseCase.state.recordList
      .filtered(years: selectedYearFilter)
      .filtered(options: selectedRecordFilter)
      .sortByLatestDate(isAscending)
    
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 30)
      
      TotalRecordCell(
        recordList: filteredList,
        myTeam: userInfoUseCase.state.myTeam ?? .noTeam
      )
      .padding(.bottom, 24)
      
      HStack {
        RecordListFilterButton(
          selectedRecordFilter: $selectedRecordFilter,
          myTeam: userInfoUseCase.state.myTeam ?? .doosan
        )
        Spacer()
        RecordListOrderButton(sortByLatestDate: $isAscending)
      }
      
      if recordUseCase.state.recordList
        .filtered(years: selectedYearFilter)
        .filtered(options: selectedRecordFilter)
        .sortByLatestDate(isAscending).isEmpty {
        HStack{
          Spacer()
          Group {
            switch selectedRecordFilter {
            case .all:
              Text("\(RecordFilter.all.label) 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
            case .teamOptions(let baseballTeam):
              Text("\(baseballTeam.sliceName) 상대 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
            case .stadiumsOptions(let string):
              Text("\(string) 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
            case .resultsOptions(let gameResult):
              Text("\(gameResult.label) 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
            }
          }
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            .font(.callout)
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 16)
        .padding(.bottom, 100)
      } else {
        ScrollView {
          ForEach(
            filteredList,
            id: \.id
          ) { record in
            Button(
              action: {
                selectedRecord = record
                recordUseCase.effect(.tappedRecordCellToEditRecordSheet(true))
              },
              label: {
                RecordCell(record: record)
              }
            )
          }
        }
        .scrollIndicators(.never)
        .padding(.top, 16)
      }
    }
    .padding(.horizontal, 16)
    .sheet(
      isPresented:
          .init(
            get: {
              recordUseCase.state.editRecordSheet
            },
            set: { result in
              recordUseCase
                .effect(.tappedRecordCellToEditRecordSheet(result))
            }
          )
      
    ) {
      if let selectedRecord = selectedRecord {
        DetailRecordView(
          to: .edit,
          record: selectedRecord,
          usecase: recordUseCase,
          changeRecords: { updateRecords in winRateUseCase.effect(.updateRecords(updateRecords)) }
        )
      }
    }
    .sheet(
      isPresented:
          .init(
            get: {
              recordUseCase.state.createRecordSheet
            },
            set: { result in
              recordUseCase
                .effect(.tappedCreateRecordSheet(result))
              if !result { selectedRecord = nil }
            }
          )
    ) {
      DetailRecordView(
        to: .create,
        record: .init(
          myTeam: winRateUseCase.state.myTeam != .noTeam ? winRateUseCase.state.myTeam : .doosan,
          vsTeam: winRateUseCase.state.myTeam != .noTeam ? winRateUseCase.state.myTeam.anyOtherTeam() : .doosan.anyOtherTeam()
        ),
        usecase: recordUseCase,
        changeRecords: { updateRecords in winRateUseCase.effect(.updateRecords(updateRecords))
        }
      )
    }
  }
}

#Preview {
  NavigationStack {
    let recordList: [GameRecordWithScoreModel] = [.init(myTeamScore: "0", vsTeamScore: "0")]
    AllRecordView(
      winRateUseCase: .init(
        recordList: recordList,
        recordService: RecordDataService(),
        myTeamService: UserDefaultsService(),
        gameRecordInfoService: .live
      ),
      userInfoUseCase: UserInfoUseCase(
        myTeamService: UserDefaultsService(),
        myNicknameService: UserDefaultsService(),
        changeIconService: ChangeAppIconService(),
        settingsService: .live
      ),
      recordUseCase: .init(
        recordList: recordList,
        recordService: RecordDataService()
      ),
      selectedYearFilter: .constant("전체")
    )
  }
}
