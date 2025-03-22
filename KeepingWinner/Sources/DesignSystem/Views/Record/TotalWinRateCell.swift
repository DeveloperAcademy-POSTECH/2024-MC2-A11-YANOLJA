//
//  TotalWinRateCell.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/23/25.
//

import SwiftUI

struct TotalWinRateCell: View {
  let recordList: [RecordModel]
  let myTeam: BaseballTeamModel?
  
  var body: some View {
    VStack {
      HStack() {
        VStack(alignment: .leading, spacing: 0) {
          Text("나의 직관 승률")
            .font(.footnote)
          Spacer()
            .frame(height: 8)
            .frame(maxWidth: .infinity)
          HStack(alignment: .bottom, spacing: 7) {
            Group {
              if let winRate = recordList.winRate {
                Text("\(winRate)%")
              } else {
                Text("--%")
              }
            }
            .font(.title)
            
            HStack(spacing: 6) {
              Text("\(listInfo.winCount)승")
              Text("\(listInfo.loseCount)패")
              Text("\(listInfo.drawCount)무")
            }
            .padding(.bottom, 3)
            .font(.callout)
          }
          .bold()
        }
        Spacer()
        RecordFaceView(
          characterModel: .init(
            symbol: myTeam?.symbol ??
            BaseballTeamModel.noTeam.symbol,
            colorHex: myTeam?.colorHex() ?? BaseballTeamModel.noTeam.colorHex(),
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
