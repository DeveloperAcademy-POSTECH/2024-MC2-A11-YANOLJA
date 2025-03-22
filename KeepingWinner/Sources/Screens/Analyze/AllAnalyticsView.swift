//
//  AllAnalyticsView.swift
//  Yanolja
//
//  Created by 박혜운 on 9/29/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct AllAnalyticsView: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var recordUseCase: AllRecordUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  
  @State var selectedCategory: String?
  
  var body: some View {
    let yearFilteredRecordList = winRateUseCase.state.yearFilteredRecordList
    
    VStack(spacing: 0) {
      Spacer()
        .frame(height: 30)
      
      TotalWinRateCell(
        recordList: yearFilteredRecordList,
        myTeam: userInfoUseCase.state.myTeam
      )
      
      Spacer()
        .frame(height: 24)
      
      VStack(spacing: 0) {
        HStack {
          HStack(spacing: 4) {
            AnalyticsListFilterButton(
              selectedRecordGrouping: .init(
                get: { winRateUseCase.state.selectedGroupingOption },
                set: { selectedOption in
                  winRateUseCase.effect(.tappedGroupingOption(selectedOption))
                }
              ),
              groupingOptions: winRateUseCase.state.groupingOptions
            )
            Spacer()
            RecordListOrderButton(
              sortByLatestDate: .init(
                get: {
                  winRateUseCase.state.isAscending
                },
                set: { _ in
                  winRateUseCase.effect(.tappedAscending)
                }
              )
            )
          }
          .foregroundStyle(.gray)
        }
        .padding(.bottom, 16)
        
        ScrollView(.vertical) {
          VStack(spacing: 12) {
            ForEach(winRateUseCase.state.selectedGroupingOptionCategories, id: \.self) { category in
              Button(
                action: {
                  selectedCategory = category
                },
                label: {
                  WinRateGraphCell(
                    myTeamSubColor: userInfoUseCase.state.myTeam?
                      .subColor() ?? BaseballTeamModel.noTeam
                      .subColor(),
                    detailOptionsName: category,
                    winRate: winRateUseCase.state
                      .selectedGroupingOptionRecords[category]?.winRate
                  )
                }
              )
            }
          }
        }
      }
    }
    .yearPickerSheet(
      isPresented: winRateUseCase.state.isPresentedYearFilterSheet,
      selectedYear: winRateUseCase.state.selectedYearFilter,
      changeYearTo: { year in winRateUseCase.effect(.setYearFilter(to: year)) },
      goBackAction: { winRateUseCase.effect(.presentingYearFilter(false)) }
    )
    .navigationDestination(
      item: $selectedCategory,
      destination: { selectedCategory in
        AnalyticsDetailView(
          winRateUseCase: winRateUseCase,
          recordUseCase: recordUseCase,
          selectedCategory: selectedCategory
        )
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(selectedCategory)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
              self.selectedCategory = nil
            }) {
              Image(systemName: "chevron.left")
                .font(.system(size: 18, weight: .semibold))
            }
            .tint(.black)
          }
        }
      }
    )
    .padding(.horizontal, 16)
    .navigationBarTitleDisplayMode(.large)
    .scrollIndicators(.never)
  }
}

#Preview {
  AllAnalyticsView(
    winRateUseCase: WinRateUseCase(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService(),
      gameRecordInfoService: .live
    ),
    recordUseCase: .init(
      recordService: RecordDataService()
    ),
    userInfoUseCase: UserInfoUseCase(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService(),
      settingsService: .preview
    )
  )
}
