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
      
      HStack {
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
          
          VStack {
            HStack {
              Text("총 직관 횟수")
                .font(.system(.body, weight: .bold))
              
              Spacer()
            }
            .padding(.leading, 16)
            
            Spacer()
            
            HStack {
              Spacer()
              
              // 총 직관 횟수
              if let recordCount = winRateUseCase.state.myWinRate
                .vsTeamRecordCount[detailTeam] {
                Text("\(recordCount)")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              } else {
                Text("--")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              }
              
              Text("회")
                .font(.body)
            }
            .padding(.trailing, 16)
          }
          .padding([.top, .bottom], 20)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        
        Spacer()
        
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
          
          VStack {
            HStack {
              Text("직관 승률")
                .font(.system(.body, weight: .bold))
              
              Spacer()
            }.padding(.leading, 16)
            
            Spacer()
            
            HStack {
              Spacer()
              
              // 직관 승률
              if let winRate = winRateUseCase.state.myWinRate.vsTeamWinRate[detailTeam] {
                Text("\(winRate)")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              } else {
                Text("--")
                  .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
              }
              
              Text("%")
                .font(.body)
            }
            .padding(.trailing, 16)
          }
          .padding([.top, .bottom], 20)
        }
        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
      }
      .padding([.leading, .trailing], 16)
      
      List {
        ForEach(recordUseCase.state.recordList, id: \.id) { list in
          // 예시 리스트 🍎🍎🍎🍎
          ZStack {
            RoundedRectangle(cornerRadius: 20)
              .foregroundColor(.pink)
              .frame(height: 162)
            
            HStack {
              VStack(alignment: .leading) {
                Text("VS")
                Text("\(detailTeam.name)")
                Text("\(list.date.gameDate()) / \(list.stadiums)")
              }
              
              Spacer()
              
              Text("\(list.result)")
                .font(.largeTitle)
            }
            .padding([.leading, .trailing], 16)
          }
          .listRowSeparator(.hidden)
          .frame(height: 162)
        }
      }
      .listStyle(.plain)
    }
  }
}

#Preview {
  VsTeamDetailView(
    winRateUseCase: WinRateUseCase(dataService: CoreDataService()),
    recordUseCase: RecordUseCase(),
    detailTeam: .kia
  )
}
