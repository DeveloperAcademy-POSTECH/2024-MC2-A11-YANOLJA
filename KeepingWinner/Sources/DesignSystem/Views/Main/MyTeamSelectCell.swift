//
//  TeamSelectCell.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSelectCell: View {
  let baseballTeam: BaseballTeamModel
  
    var body: some View {
      ZStack {
        RoundedRectangle(cornerRadius: 20)
          .fill(Color(.systemGray6))
          .frame(width: 105, height: 105)
        
        VStack {
          Text(baseballTeam.name(type: .full))
            .font(.system(.caption, weight: .bold))
            .foregroundColor(.black)
          
          Image("\(baseballTeam.symbol)")
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
  MyTeamSelectCell(baseballTeam: BaseballTeamModel.noTeam)
}
