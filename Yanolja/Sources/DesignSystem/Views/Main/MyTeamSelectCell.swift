//
//  TeamSelectCell.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSelectCell: View {
  let team: BaseballTeam
  
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .fill(.brandColor)
          .frame(width: 105, height: 105)
        
        VStack {
          Text(team.name)
            .font(.system(.caption, weight: .bold))
            .foregroundColor(.black)
          
          team.image
            .resizable()
            .scaledToFit()
            .frame(width: 70)
        }
        .padding(10)
      }
      .frame(height: 105)
    }
}

#Preview {
  MyTeamSelectCell(team: .samsung)
}
