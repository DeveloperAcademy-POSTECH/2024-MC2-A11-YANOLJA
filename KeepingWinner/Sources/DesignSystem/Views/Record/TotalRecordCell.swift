//
//  TotalRecordCell.swift
//  Yanolja
//
//  Created by 유지수 on 10/3/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct TotalRecordCell: View {
  let recordList: [RecordModel]
  let myTeam: BaseballTeamModel?
  
  var body: some View {
    VStack {
      HStack() {
        VStack(alignment: .leading, spacing: 0) {
          Text("총 \(recordList.count)경기")
            .font(.footnote)
          Spacer()
            .frame(height: 8)
            .frame(maxWidth: .infinity)
          HStack(spacing: 6) {
            Text("\(listInfo.winCount)승")
            Text("\(listInfo.loseCount)패")
            Text("\(listInfo.drawCount)무")
          }
          .font(.title)
          .bold()
        }
        Spacer()
        RecordFaceView(
          characterModel: .init(
            symbol: myTeam?.symbol ?? KeepingWinningRule.noTeamSymbol,
            colorHex: myTeam?.colorHex() ?? KeepingWinningRule.noTeamColorHex,
            totalWinRate: listInfo.winRate
          )
        )
        .frame(width: 120, height: 120)
        .offset(x: 10, y: 23)
      }
    }
    .padding(.leading, 16)
    .padding(.vertical, 16)
    .background (
      RoundedRectangle(cornerRadius: 14)
        .stroke(style: StrokeStyle(lineWidth: 0.33))
        .foregroundStyle(.gray)
        .frame(height: 92)
    )
    .frame(height: 92)
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
  
  var listInfo: (
    winCount: Int,
    loseCount: Int,
    drawCount: Int,
    winRate: Int?
  ) {
    var winCount = 0
    var loseCount = 0
    var drawCount = 0
    for record in recordList {
      guard record.result != .cancel else { continue }
      if record.result == .win { winCount += 1 }
      if record.result == .lose { loseCount += 1 }
      if record.result == .draw { drawCount += 1 }
    }
    let winOrLoseCount = winCount + loseCount
    let winRate = winOrLoseCount > 0 ? Int(Double(winCount) / Double(winOrLoseCount) * 100) : nil
    
    return (winCount, loseCount, drawCount, winRate)
  }
}

#Preview {
  TotalRecordCell(
    recordList: [],
    myTeam: .dummy
  )
}
