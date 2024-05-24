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
  @State var selectedRecord: GameRecordModel?
  
  var body: some View {
    VStack(spacing: 0) {
      let filteredList = recordUseCase.state.recordList
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
                // MARK: - 로셸
                LargeVsTeamCell(record: record)
              }
            )
          }
          .padding(.horizontal, 16)
        }
        .padding(.top, 16)
      }
    }
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
  AllRecordView(
    winRateUseCase: .init(
      dataService: CoreDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: .init(dataService: CoreDataService())
  )
}
