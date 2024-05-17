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
  var body: some View {
    Rectangle()
      .frame(width: 343, height: 162)
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
            Text("TEAM NAME")
              .font(.title)
              .fontWeight(.bold)
              .foregroundStyle(.black)
              .padding(.leading, 20)
            HStack{
              Text("Date")
                .font(.body)
                .foregroundStyle(.black)
                .padding(.leading, 20)
              Text("Stadium")
                .font(.body)
                .foregroundStyle(.black)
            }
          }
          
          Spacer()
          
          ZStack{
            Circle()
              .frame(width: 80)
              .foregroundColor(.ssg1)
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
  LargeVsTeamCell()
}
