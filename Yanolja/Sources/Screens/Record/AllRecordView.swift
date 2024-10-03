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
  @Bindable var recordUseCase: RecordUseCase
  @State var selectedRecord: GameRecordWithScoreModel?
  
  @Binding var selectedYearFilter: String // 년도 별 필터 기준
  @State var selectedRecordFilter: String = RecordFilter.initialValue
  
  var body: some View {
    VStack(spacing: 0) {
      let filteredList = recordUseCase.state.recordList
      
      Spacer()
        .frame(height: 30)
      
      TotalRecordCell(winRateUseCase: winRateUseCase, recordUseCase: recordUseCase)
        .padding(.bottom, 24)
      
      HStack {
        Menu {
          ForEach(RecordFilter.list, id: \.self) { selectedFilter in
            Button(
              action: {
                selectedRecordFilter = selectedFilter
              }
            ) {
              HStack {
                if selectedRecordFilter == selectedFilter {
                  Image(systemName: "checkmark")
                }
                Text(selectedFilter)
              }
            }
          }
        } label: {
          HStack(spacing: 4) {
            Text(selectedRecordFilter)
              .font(.subheadline)
              .foregroundStyle(.gray)
              .bold()
            Image(systemName: "chevron.down")
              .font(.subheadline)
              .foregroundStyle(.gray)
              .bold()
          }
        }
        Spacer()
        
        Button(action: {
          // 정렬 순서 변경 포인트
        }) {
          Image(systemName: "arrow.up.arrow.down")
            .font(.subheadline)
            .foregroundStyle(.gray)
            .bold()
        }
      }
      
      if filteredList.isEmpty {
        HStack{
          Spacer()
          Text("직관 기록이 없습니다. \n직관 기록을 추가하세요!")
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
          ForEach(recordUseCase.state.recordList.sorted { $0.date > $1.date }, id: \.id) { record in
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
          .padding(.horizontal, 16)
        }
        .padding(.top, 25)
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
          myTeam: winRateUseCase.state.myTeam,
          vsTeam: winRateUseCase.state.myTeam.anyOtherTeam()
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
    AllRecordView(
      winRateUseCase: .init(
        recordService: RecordDataService(),
        myTeamService: UserDefaultsService()
      ),
      recordUseCase: .init(recordService: RecordDataService()),
      selectedYearFilter: .constant("전체")
    )
  }
}
