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
  @Bindable var recordUseCase: AllRecordUseCase
  @State var selectedRecord: RecordModel?
  
  @Binding var plusButtonTapped: Bool
  @State var selectedRecordFilter: RecordFilter = RecordFilter.initialValue
  
  var body: some View {
    let filteredList = recordUseCase.state.recordList
      .filtered(year: recordUseCase.state.selectedYearFilter)
      .filtered(options: selectedRecordFilter)
      .sortByLatestDate(recordUseCase.state.isAscending)
    
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 30)
      
      TotalRecordCell(
        recordList: filteredList,
        myTeam: userInfoUseCase.state.myTeam
      )
      .padding(.bottom, 24)
      
      HStack {
        RecordListFilterButton(
          recordUseCase: recordUseCase,
          selectedRecordFilter: $selectedRecordFilter,
          myTeamSymbol: userInfoUseCase.state.myTeam?.symbol ?? BaseballTeamModel.noTeam.symbol
        )
        Spacer()
        RecordListOrderButton(
          sortByLatestDate: .init(
            get: { recordUseCase.state.isAscending },
            set: { _ in recordUseCase.effect(.tappedAscending) }
          ),
          firstTitle: "최근 순",
          secondTitle: "이전 순"
        )
      }
      
      if recordUseCase.state.recordList
        .filtered(year: recordUseCase.state.selectedYearFilter)
        .filtered(options: selectedRecordFilter)
        .sortByLatestDate(recordUseCase.state.isAscending).isEmpty {
        HStack{
          Spacer()
          Group {
            switch selectedRecordFilter {
            case .all:
              Text("\(RecordFilter.all.label) 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
            case .teamOptions(let baseballTeam):
              Text("\(baseballTeam) 상대 직관 기록이 없습니다 \n직관 기록을 추가하세요!")
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
      item: $selectedRecord,
      content: { selectedRecord in

        DetailRecordView(
          to: .edit(selectedRecord),
          editRecord: { record in
            winRateUseCase.effect(.editRecord(record))
            recordUseCase.effect(.editRecord(record))
          },
          removeRecord: { id in
            winRateUseCase.effect(.removeRecord(id))
            recordUseCase.effect(.removeRecord(id))
            
          },
          goBackAction: { self.selectedRecord = nil }
        )
      }
    )
    .sheet(
      isPresented: $plusButtonTapped
    ) {
      DetailRecordView(
        to: .new,
        newRecord: { record in
          winRateUseCase.effect(.newRecord(record))
          recordUseCase.effect(.newRecord(record))
        },
        goBackAction: { plusButtonTapped = false }
      )
    }
    .yearPickerSheet(
      isPresented: recordUseCase.state.isPresentedYearFilterSheet,
      selectedYear: recordUseCase.state.selectedYearFilter,
      changeYearTo: { year in recordUseCase.effect(.setYearFilter(to: year)) },
      goBackAction: { recordUseCase.effect(.presentingYearFilter(false)) }
    )
  }
}

#Preview {
  NavigationStack {
    AllRecordView(
      winRateUseCase: .init(
        recordService: RecordDataService(),
        myTeamService: UserDefaultsService(),
        gameRecordInfoService: .live
      ),
      userInfoUseCase: UserInfoUseCase(
        myTeamService: UserDefaultsService(),
        myNicknameService: UserDefaultsService(),
        changeIconService: ChangeAppIconService(),
        settingsService: .preview
      ),
      recordUseCase: .init(
        recordService: RecordDataService()
      ),
      plusButtonTapped: .constant(false)
    )
  }
}
