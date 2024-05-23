//
//  AllRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AllRecordView: View {
  @State var selectedRecord: GameRecordModel?
  @Bindable var useCase: RecordUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      
      let filteredList = useCase.state.recordList
      
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
          ForEach(useCase.state.recordList, id: \.id) { record in
            Button(
              action: {
                selectedRecord = record
                useCase.effect(.tappedRecordCellToEditRecordSheet(true))
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
              useCase.state.editRecordSheet
            },
            set: { result in
              useCase
                .effect(.tappedRecordCellToEditRecordSheet(result))
            }
          )
    ) {
      if let selectedRecord = selectedRecord {
        DetailRecordView(
          to: .edit,
          record: selectedRecord,
          usecase: useCase
        )
      }
    }
    .sheet(
      isPresented:
          .init(
            get: {
              useCase.state.createRecordSheet
            },
            set: { result in
              useCase
                .effect(.tappedCreateRecordSheet(result))
              if !result { selectedRecord = nil }
            }
          )
    ) {
      DetailRecordView(to: .create, usecase: useCase)
    }
  }
}

#Preview {
  AllRecordView(useCase: .init())
}
