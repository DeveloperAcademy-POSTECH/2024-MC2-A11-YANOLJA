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
    ZStack {
      VStack {
        HStack(spacing: 0) {
          // 경기가 취소되었을 경우 점수가 아닌 "--"로 표시
          if record.isCancel {
            Text("--")
              .jikyoFont(.recordCell)
              .foregroundStyle(myTeamScoreColor())
              .frame(width: 70, height: 70)
          } else {
            Text(record.myTeamScore)
              .jikyoFont(.recordCell)
              .foregroundStyle(myTeamScoreColor())
              .frame(width: 70, height: 70)
          }
          Spacer()
          VStack {
            HStack(spacing: 8) {
              Text(record.myTeam.name.split(separator: " ").first ?? "")
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .frame(width: 50)
              Text("vs")
                .font(.subheadline)
                .foregroundStyle(.gray)
              Text(record.vsTeam.name.split(separator: " ").first ?? "")
                .font(.title)
                .foregroundStyle(.black)
                .bold()
                .frame(width: 50)
            }
            .padding(.bottom, 2)
            
            Text(record.date.gameDate())
              .font(.caption2)
              .foregroundStyle(.date)
            Text(record.stadiums.name)
              .font(.caption2)
              .foregroundStyle(.date)
          }
          Spacer()
          ZStack(alignment: .center) {
            // 경기가 취소되었을 경우 점수가 아닌 "--"로 표시
            if record.isCancel {
              Text("--")
                .jikyoFont(.recordCell)
                .foregroundStyle(vsTeamScoreColor())
                .frame(width: 70, height: 70)
            } else {
              Text(record.vsTeamScore)
                .jikyoFont(.recordCell)
                .foregroundStyle(vsTeamScoreColor())
                .frame(width: 70, height: 70)
            }
          }
        }
      }
      .padding(.horizontal, 16)
      .padding(.vertical, 24)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(.bg)
      )
      
      Path { path in
        path.move(to: CGPoint(x: 0, y: 2))
        path.addLine(to: CGPoint(x: 0, y: 118))
      }
      .stroke(style: StrokeStyle(lineWidth: 2, dash: [6]))
      .foregroundStyle(
        Color.init(hex: 0xC7C7CC)
          .opacity(0.35)
      )
      .frame(width: 2, height: 118)
    }
    
  }
  
  func myTeamScoreColor() -> Color {
    guard !record.isCancel else {
      return .gray
    }
    switch record.result {
    case .win:
      return record.myTeam.mainColor
    case .lose:
      return .gray
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
