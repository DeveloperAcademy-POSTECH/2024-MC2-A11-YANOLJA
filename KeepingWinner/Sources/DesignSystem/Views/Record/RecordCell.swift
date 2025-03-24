//
//  RecordCell.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct RecordCell: View {
  let record: RecordModel
  
  var body: some View {
    ZStack {
      VStack {
        HStack(spacing: 0) {
          // 경기가 취소되었을 경우 점수가 아닌 "-"로 표시
          if record.isCancel {
            Text("-")
              .jikyoFont(.recordCell)
              .foregroundStyle(myTeamScoreColor())
              .opacity(0.5)
              .frame(width: 70, height: 70)
          } else {
            Text(record.myTeamScore)
              .jikyoFont(.recordCell)
              .foregroundStyle(myTeamScoreColor())
              .frame(width: 70, height: 70)
          }
          Spacer()
          VStack {
            HStack(spacing: 0) {
              Text(record.myTeam.name(year: record.date.year))
                .font(.title)
                .bold()
                .foregroundStyle(.black)
                .opacity(record.isCancel ? 0.5 : 1)
                .frame(width: 70)
                .multilineTextAlignment(.trailing)
              Text("vs")
                .font(.subheadline)
                .foregroundStyle(.gray)
                .opacity(record.isCancel ? 0.5 : 1)
                .frame(width: 16)
              Text(record.vsTeam.name(year: record.date.year))
                .font(.title)
                .foregroundStyle(.black)
                .bold()
                .opacity(record.isCancel ? 0.5 : 1)
                .frame(width: 70)
                .multilineTextAlignment(.leading)
            }
            .padding(.bottom, 2)
            
            switch record.isDoubleHeader {
            case 0:
              Text("\(record.date.gameDate()) DH1")
                .font(.caption2)
                .opacity(record.isCancel ? 0.5 : 1)
                .foregroundStyle(.date)
            case 1:
              Text("\(record.date.gameDate()) DH2")
                .font(.caption2)
                .opacity(record.isCancel ? 0.5 : 1)
                .foregroundStyle(.date)
            default:
              Text(record.date.gameDate())
                .font(.caption2)
                .opacity(record.isCancel ? 0.5 : 1)
                .foregroundStyle(.date)
            }
            Text(record.stadium.name(year: record.date.year))
              .font(.caption2)
              .opacity(record.isCancel ? 0.5 : 1)
              .foregroundStyle(.date)
          }
          Spacer()
          ZStack(alignment: .center) {
            // 경기가 취소되었을 경우 점수가 아닌 "-"로 표시
            if record.isCancel {
              Text("-")
                .jikyoFont(.recordCell)
                .foregroundStyle(vsTeamScoreColor())
                .opacity(0.5)
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
          .opacity(record.isCancel ? 0.5 : 1)
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
      .opacity(record.isCancel ? 0.5 : 1)
      .frame(width: 2, height: 118)
    }
    
  }
  
  func myTeamScoreColor() -> Color {
    guard !record.isCancel else {
      return Color(.systemGray4)
    }
    switch record.result {
    case .win:
      return record.myTeam.color()
    case .lose:
      return Color(.systemGray4)
    case .draw:
      return Color(.systemGray4)
    case .cancel:
      return Color(.systemGray4)
    }
  }
  
  func vsTeamScoreColor() -> Color {
    guard !record.isCancel else {
      return Color(.systemGray4)
    }
    switch record.result {
    case .win:
      return Color(.systemGray4)
    case .lose:
      return .gray
    case .draw:
      return Color(.systemGray4)
    case .cancel:
      return Color(.systemGray4)
    }
  }
}

#Preview {
  RecordCell(
    record: .init(stadium: .dummy, myTeam: .dummy, vsTeam: .dummy)
  )
}
