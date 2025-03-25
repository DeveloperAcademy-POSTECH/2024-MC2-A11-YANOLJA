//
//  RecordListFilterButton.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct RecordListFilterButton: View {
  @Bindable var recordUseCase: AllRecordUseCase
  @Binding var selectedRecordFilter: RecordFilter
  let myTeamSymbol: String
  
  var body: some View {
    Menu {
      RecordFilterLabel(
        selectedRecordFilter: $selectedRecordFilter,
        recordFilter: .all,
        showLabel: RecordFilter.all.label
      )
      Menu(RecordFilter.teamOptions("doosan").label) {
        ForEach(
          recordUseCase.state.baseballTeams.filter { $0.symbol != myTeamSymbol },
          id: \.symbol) { team in
            let name = team
              .name(year: recordUseCase.state.selectedYearFilter, type: .full)
            RecordFilterLabel(
              selectedRecordFilter: $selectedRecordFilter,
              recordFilter: .teamOptions(name),
              showLabel: name
            )
            .tag(team)
          }
      }
      Menu(RecordFilter.stadiumsOptions("").label) {
        ForEach(
          recordUseCase.state.stadiumFilterOptions,
          id: \.self) { stadiumName in
            RecordFilterLabel(
              selectedRecordFilter: $selectedRecordFilter,
              recordFilter: .stadiumsOptions(stadiumName),
              showLabel: stadiumName
            )
            .tag(stadiumName)
          }
      }
      Menu(RecordFilter.resultsOptions(.cancel).label) {
        ForEach(GameResult.allCases, id: \.self) { result in
          RecordFilterLabel(
            selectedRecordFilter: $selectedRecordFilter,
            recordFilter: .resultsOptions(result),
            showLabel: result.label
          )
        }
      }
    } label: {
      HStack(spacing: 4) {
        Text(selectedRecordFilter.label)
          .font(.subheadline)
          .foregroundStyle(.gray)
          .bold()
        Image(systemName: "chevron.down")
          .font(.subheadline)
          .foregroundStyle(.gray)
          .bold()
      }
    }
  }
}

#Preview {
  RecordListFilterButton(
    recordUseCase: .init(recordService: RecordDataService()),
    selectedRecordFilter: .constant(.all),
    myTeamSymbol: "doosan"
  )
}
