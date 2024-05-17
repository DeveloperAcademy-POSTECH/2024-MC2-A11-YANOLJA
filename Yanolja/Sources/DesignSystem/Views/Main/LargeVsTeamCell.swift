//
//  LargeVsTeamCell.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - 로셸
struct LargeVsTeamCell: View {
  let record: GameRecordModel
  
  var body: some View {
    Rectangle()
      .frame(height: 162)
      .foregroundColor(.brandColor)
      .cornerRadius(20.0)
      .overlay {
        HStack{
          VStack(alignment: .leading){
            Text("VS")
              .font(.title2)
              .fontWeight(.medium)
              .foregroundColor(.black)
              .opacity(0.7)
              .padding(.leading, 20)
            Text(record.vsTeam.name)
              .font(.title)
              .fontWeight(.bold)
              .foregroundStyle(.black)
              .padding(.leading, 20)
            HStack{
              Text(record.date.gameDate())
                .font(.body)
                .foregroundStyle(.black)
                .padding(.leading, 20)
              Text(record.stadiums.title)
                .font(.body)
                .foregroundStyle(.black)
            }
          }
          
          Spacer()
          
          ZStack{
            Circle()
              .frame(width: 80)
              .foregroundColor(record.vsTeam.mainColor)
              .padding(.trailing, 20)
            
            Text("승")
              .font(.largeTitle)
              .fontWeight(.bold)
              .foregroundStyle(.white)
              .padding(.trailing, 20)
          }
        }
      }
  }
}

#Preview {
  LargeVsTeamCell(record: .init())
}
