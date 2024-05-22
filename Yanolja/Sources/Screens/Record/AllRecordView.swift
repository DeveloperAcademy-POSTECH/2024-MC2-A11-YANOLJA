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
