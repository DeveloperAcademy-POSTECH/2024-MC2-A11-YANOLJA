//
//  MyTeamSelectView.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSelectView: View {
  
  @State var selectedTeam: BaseballTeam?
  var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  var body: some View {
    
    HStack{
      Text("나의 팀을 \n선택해 주세요")
        .font(.system(.largeTitle, weight: .bold))
      Spacer()
    }
    .padding(.leading, 16)
    .padding(.top, 20)
    
    LazyVGrid(columns: columns) {
      ForEach(BaseballTeam.allCases, id: \.self) { team in
        Button(
          action: {
            selectedTeam = team
          },
          label: {
            MyTeamSelectCell(team: team)
            .cornerRadiusWithBorder(
              radius: 20,
              borderColor: .black.opacity(0.3),
              lineWidth: selectedTeam == team ? 2 : 0
            )
          }
        )
        .padding(.bottom, 16)
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 21)
    
    Spacer()
    
    Button(
      action: {
        // MARK: - 첫 화면으로 이동
      },
      label: {
        ZStack {
          RoundedRectangle(cornerRadius: 10)
            .foregroundColor(selectedTeam != nil ? .black : .gray)
            .frame(height: 48)
          Text("시작하기")
            .foregroundColor(.white)
            .font(.system(.headline, weight: .bold))
        }
      }
    )
    .disabled(selectedTeam == nil)
    .padding(.horizontal, 16)
    .padding(.bottom, 41)
  }
}

#Preview {
  MyTeamSelectView()
}
