//
//  TotalWinRateView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MainView: View {
  @Bindable var usecase: WinRateUseCase
  
  var body: some View {
    VStack(spacing: 30) {
      BubbleTextView(text: "직관을 기록하고 나의 승리 기여도를 확인하세요")
      
      Circle()
        .overlay {
          Text("^-^")
            .foregroundStyle(.white)
        }
        .frame(width: 300)
      
      VStack(spacing: 3) {
        Text("평균 직관 승리 기여도")
          .font(.footnote)
        Text("\(usecase.state.myWinRate.totalWinRate.map{ String($0) } ?? "--")%")
          .font(.title)
          .fontWeight(.bold)
      }
      
      // MARK: - 구름 꺼
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          Button(
            action: {
              usecase.effect(.tappedTeamWinRateCell)
            },
            label: {
              Rectangle()
                .frame(width: 161, height: 105)
                .overlay {
                  Text("구름꺼")
                    .foregroundStyle(.white)
                }
            }
          )
          .sheet(
            isPresented:
              .init(
                get: {
                  usecase.state.tappedTeamWinRateCell
                },
                set: { _ in
                  usecase.effect(.tappedTeamWinRateCell)
                }
              ),
            content: {
              EachTeamWinRateDetailView()
            }
          )
        }
        .padding(.horizontal, 15)
      }
    }
  }
}

#Preview {
  MainView(usecase: .init())
}
