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
  
  init(
    winRateUseCase: WinRateUseCase,
    recordUseCase: RecordUseCase,
    detailTeam: BaseballTeam
  ) {
    self.winRateUseCase = winRateUseCase
    self.recordUseCase = recordUseCase
    self.detailTeam = detailTeam
    print(detailTeam)
  }
  
  var body: some View {
    VStack {
      HStack {
        Text(detailTeam.name) // 구단 이름
          .font(.system(.title2, weight: .bold))
        Spacer()
      }
      .padding(.leading, 16) // 수정 예정
      .padding(.bottom, 20)
      
      HStack {
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.brandColor)
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
          
          VStack {
            HStack {
              Text("총 직관 횟수")
                .font(.callout)
              
              Spacer()
            }
            .padding(.leading, 16)
            
            Spacer()
            
            HStack {
              Spacer()
              
              // 총 직관 횟수
              if let recordCount = winRateUseCase.state.myWinRate
                .vsTeamRecordCount[detailTeam] {
                Text("\(recordCount.map { String($0) } ?? "--")")
                  .font(.system(.largeTitle, weight: .bold))
              } else {
                Text("--")
                  .font(.system(.largeTitle, weight: .bold))
              }
              
              Text("회")
                .font(.subheadline)
            }
            .padding(.trailing, 16)
          }
          .padding(.vertical, 20)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        
        Spacer()
        
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(.brandColor)
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
          
          VStack {
            HStack {
              Text("직관 승률")
                .font(.callout)
              
              Spacer()
            }.padding(.leading, 16)
            
            Spacer()
            
            HStack {
              Spacer()
              
              // 직관 승률
              if let winRate = winRateUseCase.state.myWinRate.vsTeamWinRate[detailTeam] {
                Text("\(winRate.map{ String($0) } ?? "--")")
                  .font(.system(.largeTitle, weight: .bold))
              } else {
                Text("--")
                  .font(.system(.largeTitle, weight: .bold))
              }
              
              Text("%")
                .font(.subheadline)
            }
            .padding(.trailing, 16)
          }
          .padding(.vertical, 20)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
      }
      .padding(.horizontal, 16)
      
      List {
        ForEach(recordUseCase.state.recordList, id: \.id) { list in
          
          Button (action: {
            // 커식 씨 View 추가 필요
          }
                  ,label: {
            LargeVsTeamCell(record: list)
          })
          .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
    }
    .padding(.top, 30)
  }
}

#Preview {
  VsTeamDetailView(
    winRateUseCase: WinRateUseCase(dataService: CoreDataService()),
    recordUseCase: RecordUseCase(),
    detailTeam: .kia
  )
}
