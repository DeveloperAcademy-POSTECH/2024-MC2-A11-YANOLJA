//
//  MyTeamSelectView.swift
//  Yanolja
//
//  Created by 유지수 on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct MyTeamSelectView: View {
  private let completeSelectionAction: (BaseballTeam) -> Void
  @State var selectedTeam: BaseballTeam?
  private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
  
  init(
    completeSelectionAction: @escaping (BaseballTeam) -> Void
  ) {
    self.completeSelectionAction = completeSelectionAction
  }
  
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
        .padding(.bottom, 10)
      }
    }
    .padding(.horizontal, 16)
    .padding(.top, 10)
    
    Spacer()
    
    Button(
      action: {
        // MARK: - 첫 화면으로 이동
        if let team = selectedTeam {
          completeSelectionAction(team)
        }
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
  }
}

#Preview {
  MyTeamSelectView(
    completeSelectionAction: { _ in }
  )
}
