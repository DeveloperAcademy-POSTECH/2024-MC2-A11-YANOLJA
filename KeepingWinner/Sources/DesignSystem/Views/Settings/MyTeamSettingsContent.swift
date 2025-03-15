//
//  MyTeamSelectView.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSettingsContent: View {
  let baseballTeams: [BaseballTeamModel]
  @Binding var selectedTeam: BaseballTeamModel?
  private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  init(
    baseballTeams: [BaseballTeamModel],
    selectedTeam: Binding<BaseballTeamModel?>
  ) {
    self.baseballTeams = baseballTeams
    self._selectedTeam = selectedTeam
  }
  
  var body: some View {
    LazyVGrid(columns: columns) {
      ForEach(baseballTeams, id: \.id) { model in
        Button(
          action: {
            selectedTeam = model
          },
          label: {
            MyTeamSelectCell(baseballTeam: model)
            .cornerRadiusWithBorder(
              radius: 20,
              borderColor: Color(.systemGray3),
              lineWidth: selectedTeam?.name() == model.name() ? 2 : 0
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
  MyTeamSettingsContent(
    baseballTeams: [],
    selectedTeam: .constant(nil)
  )
}
