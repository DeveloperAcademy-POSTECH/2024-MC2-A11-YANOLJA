//
//  MediumVsTeamCell.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - 구름
struct MediumVsTeamCell: View {
  let team: BaseballTeam
  var body: some View {
    Rectangle()
      .frame(width: 161, height: 105)
      .overlay {
        Text(team.name)
          .foregroundStyle(.white)
      }
  }
}

#Preview {
  MediumVsTeamCell(team: .kia)
}
