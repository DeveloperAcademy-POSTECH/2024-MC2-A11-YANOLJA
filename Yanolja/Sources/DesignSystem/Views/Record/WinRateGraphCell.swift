//
//  GameRecordCell.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct WinRateGraphCell: View {
  let myTeamSubColor: Color
  let detailOptionsName: String
  let winRate: Int?
  
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 2) {
        Text(detailOptionsName)
          .font(.caption2)
          .bold()
          .foregroundStyle(.gray)
        Group {
          if let winRate {
            Text("\(winRate)%")
          } else {
            Text("--%")
          }
        }
        .font(.body)
        .bold()
        .foregroundStyle(.black)
      }
      Spacer()
      Image(systemName: "chevron.forward")
        .tint(.gray)
    }
    .padding(.vertical, 12)
    .padding(.horizontal, 16)
    .background {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color.bg)  // 배경색 설정
        
        GeometryReader { geometry in
          RoundedRectangle(cornerRadius: 10)
            .fill(myTeamSubColor)
            .frame(
              width: widthForWinRate(geometry: geometry),  // winRate에 비례하는 너비
              height: geometry.size.height
            )
        }
      }
    }
  }
  
  private func widthForWinRate(geometry: GeometryProxy) -> CGFloat {
    guard let rate = winRate else { return 0 }
    // 0-100 사이의 winRate 값을 부모 뷰의 너비에 비례하게 계산
    let maxWidth = geometry.size.width
    return maxWidth * CGFloat(rate) / 100
  }
}

#Preview {
  WinRateGraphCell(myTeamSubColor: BaseballTeam.kiwoom.subColor, detailOptionsName: BaseballTeam.ssg.name, winRate: 50)
}
