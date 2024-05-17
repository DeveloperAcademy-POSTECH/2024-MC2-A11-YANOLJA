//
//  AllRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct AllRecordView: View {
  @Bindable var useCase: RecordUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        ForEach(useCase.state.recordList, id: \.id) { record in
          Button(
            action: {
              useCase.effect(.tappedRecordCell)
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
            useCase.state.tappedRecordCell
          },
          set: { _ in
            useCase
              .effect(.tappedRecordCell)
          }
        )
    ) {
      DetailRecordView(to: .edit)
    }
    .sheet(
      isPresented:
        .init(
          get: {
          useCase.state.tappedPlusButton
          },
          set: { _ in
            useCase
              .effect(.tappedAddButton)
          }
        )
    ) {
      DetailRecordView(to: .create)
    }
  }
}

#Preview {
  AllRecordView(useCase: .init())
}
