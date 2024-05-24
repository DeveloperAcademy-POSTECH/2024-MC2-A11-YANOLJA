//
//  SelectTeamView.swift
//  Yanolja
//
//  Created by Guisik Han on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct SelectTeamView: View {
  @Binding var selectedTeam: BaseballTeam
  private let type: SelectType
//  private let tappedAction: (BaseballTeam) -> Void
  
  init(
    type: SelectType,
    selectedTeam: Binding<BaseballTeam>
//    tappedAction: @escaping (BaseballTeam
//    ) -> Void) 
  ) {
    self.type = type
    self._selectedTeam = selectedTeam
//    self.tappedAction = tappedAction
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text(type.title)
      selectedTeam
        .image
        .resizable()
        .scaledToFit()
      
      HStack {
        Picker(
          "",
          selection: $selectedTeam
//              .init(
//            get: { selectedTeam },
//            set: { team in
//              selectedTeam = team
//              tappedAction(team)
//            }
//              )
          ,
          content: {
            if case let .vs(myteam) = type {
              ForEach(BaseballTeam.allCases.filter{ $0 != myteam }, id: \.self) { team in
                HStack {
                  Text(team.name)
                  Spacer()
                }
              }
            } else {
              ForEach(BaseballTeam.allCases, id: \.self) { team in
                HStack {
                  Text(team.name)
                  Spacer()
                }
              }
            }
          }
        )
        .accentColor(.gray)
        .labelsHidden()
        .pickerStyle(MenuPickerStyle())
        .accentColor(.gray)
      }
    }
  }
}

extension SelectTeamView {
  enum SelectType: Equatable {
    case my
    case vs(myteam: BaseballTeam)
    
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
    selectedTeam: .constant(.doosan)
//    ,
//    tappedAction: { team in print(team) }
  )
}

