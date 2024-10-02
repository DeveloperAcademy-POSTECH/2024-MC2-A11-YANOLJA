//
//  MyTeamSelectView.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSettingsContentView: View {
  @Binding var selectedTeam: BaseballTeam?
  private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  init(selectedTeam: Binding<BaseballTeam?>) {
    self._selectedTeam = selectedTeam
  }
  
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(BaseballTeam.allCases, id: \.self) { team in
        Button(
          action: {
            selectedTeam = team
          },
          label: {
            MyTeamSelectCell(team: team)
            .cornerRadiusWithBorder(
              radius: 20,
              borderColor: .black.opacity(0.3),
              lineWidth: selectedTeam == team ? 2 : 0
            )
          }
        )
        .padding(.bottom, 10)
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 10)
  }
}

#Preview {
  MyTeamSettingsContentView(
    selectedTeam: .constant(nil)
  )
}
