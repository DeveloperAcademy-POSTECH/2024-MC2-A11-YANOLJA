//
//  AllHistoryView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct ListHistoryView: View {
  @Bindable var usecase: HistoryUseCase
  
  var body: some View {
    VStack(spacing: 0) {
      ScrollView {
        ForEach(usecase.state.historyList, id: \.id) { record in
          Button(
            action: {
              usecase.effect(.tappedHistoryCell)
            },
            label: {
              Rectangle()
                .frame(width: 340, height: 105)
                .overlay {
                  Text("로셸 꺼")
                    .foregroundStyle(.white)
                }
            }
          )
        }
      }
    }
    .sheet(
      isPresented:
        .init(
          get: {
            usecase.state.tappedHistoryCell
          },
          set: { _ in
            usecase
              .effect(.tappedHistoryCell)
          }
        )
    ) {
      EditHistoryView(to: .edit)
    }
    .sheet(
      isPresented:
        .init(
          get: {
          usecase.state.tappedPlusButton
          },
          set: { _ in
            usecase
              .effect(.tappedAddButton)
          }
        )
    ) {
      EditHistoryView(to: .new)
    }
  }
}

#Preview {
  ListHistoryView(usecase: .init())
}
