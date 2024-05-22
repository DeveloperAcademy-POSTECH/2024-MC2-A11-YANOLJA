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
  let winRate: Int?
  
  var body: some View {
    Rectangle()
      .frame(width: 120, height: 130) // 텍스트 크기에 맞게 변동되게 할 수 있을까?
      .overlay {

        VStack(alignment: .center, spacing: 12){
          VStack(alignment: .center, spacing: 4){
            Text("VS") // 고정 텍스트
              .font(.caption)
              .fontWeight(.regular)
              .foregroundStyle(.black.opacity(0.5))
            
            Text(team.name) // BaseballTeam 데이터 연결
              .font(.subheadline)
              .fontWeight(.semibold)
              .foregroundStyle(.black)
          }
          
          Circle()
            .frame(width: 52, height: 52)
            .foregroundColor(team.mainColor) // 팀 컬러 연결
            .shadow(color: .black.opacity(0.2), radius: 4, x: 4, y: 4)
            .overlay{
              HStack(spacing: 0){
                // 승률 데이터가 있을 경우
                if let rate = winRate {
                  Text("\(rate)") // WinRate 데이터 연결
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                }
                // 승률 데이터가 없을 경우
                else {
                  Text("--") // 고정 텍스트
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                }
                
                Text("%") // 고정 텍스트
                  .font(.caption2)
                  .fontWeight(.regular)
                  .foregroundStyle(.white)
              }
            }
        }
      }
      .cornerRadius(20.0)
      .foregroundColor(.gray.opacity(0.05))
  }
}

#Preview {
  MediumVsTeamCell(team: .doosan, winRate: nil)
}
