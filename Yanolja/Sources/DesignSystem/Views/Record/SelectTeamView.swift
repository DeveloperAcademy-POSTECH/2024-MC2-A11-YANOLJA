//
//  SelectTeamView.swift
//  Yanolja
//
//  Created by Guisik Han on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct SelectTeamView: View {
  @State var selectedTeam: BaseballTeam
  private let type: SelectType
  private let tappedAction: (BaseballTeam) -> Void
  
  
  init(
    type: SelectType,
    selectedTeam: BaseballTeam,
    tappedAction: @escaping (BaseballTeam
    ) -> Void) {
    self.type = type
    self.selectedTeam = selectedTeam
    self.tappedAction = tappedAction
  }
  
  
  var body: some View {
    VStack(spacing: 0) {
      Text(type.title)
      
      selectedTeam
        .image
        .resizable()
        .scaledToFit()
      
      HStack() {
        Picker(
          "",
          selection: .init(
            get: { selectedTeam },
            set: { team in
              selectedTeam = team
              tappedAction(team)
            }
          ),
          content: {
            ForEach(BaseballTeam.allCases, id: \.self) { team in
              HStack {
                Text(team.name)
                Spacer()
                
              }
            }
          }
        )
        .labelsHidden()
      }
      
    }
  }
}

extension SelectTeamView {
  enum SelectType {
    case my
    case vs
    
    var title: String {
      switch self {
      case .my:
        return "나의 팀"
      case .vs:
        return "상대 팀"
      }
    }
  }
}

#Preview {
  SelectTeamView(
    type: .my,
    selectedTeam: .doosan,
    tappedAction: { team in print(team) }
  )
}
