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
  }
  
  var body: some View {
    NavigationStack {
      VStack {
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
      }
      .padding(.horizontal, 16)
      
      let filteredList = recordUseCase
        .state
        .recordList
        .filter{ list in
          list.vsTeam == detailTeam
        }
      
      if filteredList.isEmpty {
        HStack{
          Spacer()
          Text("\(detailTeam.name)와의 직관 기록이 없습니다.")
            .foregroundColor(.gray)
            .font(.callout)
          Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        VStack {
          ForEach(
            recordUseCase
              .state
              .recordList
              .filter{ list in
                list.vsTeam == detailTeam
              },
            id: \.id
          ) { list in
            NavigationLink(
              destination: {
                DetailRecordView(
                  to: .edit,
                  record: list,
                  usecase: recordUseCase,
                  changeRecords: { updateRecords in winRateUseCase.effect(.updateRecords(updateRecords))
                  }
                )
                .navigationBarBackButtonHidden()
              },
              label: {
                LargeVsTeamCell(record: list)
              }
            )
          }
          Spacer()
        }
      }
    }
    .padding(.top, 30)
    .padding(.horizontal, 16)
  }
}


#Preview {
  VsTeamDetailView(
    winRateUseCase: WinRateUseCase(
      dataService: CoreDataService(),
      myTeamService: UserDefaultsService()
    ),
    recordUseCase: RecordUseCase(dataService: CoreDataService()),
    detailTeam: .kia
  )
}
