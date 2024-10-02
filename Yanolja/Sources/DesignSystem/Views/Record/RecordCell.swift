//
//  RecordCell.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct RecordCell: View {
  let record: GameRecordWithScoreModel
  
  var body: some View {
    VStack {
      HStack(spacing: 0) {
        Text(record.myTeamScore)
          .jikyoFont(.recordCell)
          .foregroundStyle(myTeamScoreColor())
          .frame(width: 70, height: 70)
        Spacer()
        VStack {
          HStack(spacing: 8) {
            Text(record.myTeam.name.split(separator: " ").first ?? "")
              .font(.title)
              .bold()
              .frame(width: 50)
            Text("vs")
              .font(.subheadline)
              .foregroundStyle(.gray)
            Text(record.vsTeam.name.split(separator: " ").first ?? "")
              .font(.title)
              .bold()
              .frame(width: 50)
          }
          
          Text(record.date.gameDate())
          Text(record.stadiums)
        }
        Spacer()
        ZStack(alignment: .center) {
          Text(record.vsTeamScore)
            .jikyoFont(.recordCell)
            .foregroundStyle(vsTeamScoreColor())
            .frame(width: 70, height: 70)
        }
      }
    }
    .padding(.horizontal, 16)
    .padding(.vertical, 24)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(.bg)
    )
    
  }
  
  func myTeamScoreColor() -> Color {
    guard !record.isCancel else {
      return .gray
    }
    switch record.result {
    case .win:
      return record.myTeam.mainColor
    case .lose:
      return record.vsTeam.mainColor
    case .draw:
      return .gray
    }
  }
  
  func vsTeamScoreColor() -> Color {
    guard !record.isCancel else {
      return .gray
    }
    switch record.result {
    case .win:
      return .gray
    case .lose:
      return .gray
    case .draw:
      return .gray
    }
  }
}

#Preview {
  RecordCell(record: .init(myTeamScore: "3", vsTeamScore: "0"))
}
