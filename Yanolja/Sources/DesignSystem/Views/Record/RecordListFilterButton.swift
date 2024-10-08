//
//  RecordListFilterButton.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct RecordListFilterButton: View {
  @Binding var selectedRecordFilter: RecordFilter
  let myTeam: BaseballTeam
  
  var body: some View {
    Menu {
      RecordFilterLabel(
        selectedRecordFilter: $selectedRecordFilter,
        recordFilter: .all,
        showLabel: RecordFilter.all.label
      )
      Menu(RecordFilter.teamOptions(.doosan).label) {
        ForEach(BaseballTeam.recordBaseBallTeam, id: \.name) { team in
          RecordFilterLabel(
            selectedRecordFilter: $selectedRecordFilter,
            recordFilter: .teamOptions(team),
            showLabel: team.name
          )
        }
      }
      Menu(RecordFilter.stadiumsOptions("").label) {
        ForEach(BaseballStadiums.nameList.filter { $0 != myTeam.name }, id: \.self) { stadiums in
          RecordFilterLabel(
            selectedRecordFilter: $selectedRecordFilter,
            recordFilter: .stadiumsOptions(stadiums),
            showLabel: stadiums
          )
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
  RecordListFilterButton(selectedRecordFilter: .constant(.all), myTeam: .doosan)
}
