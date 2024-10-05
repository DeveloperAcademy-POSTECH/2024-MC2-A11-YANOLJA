//
//  SelectTeamView.swift
//  Yanolja
//
//  Created by Guisik Han on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct SelectTeamBlock: View {
  @Binding var selectedTeam: BaseballTeam
  private let type: SelectType
  
  init(
    type: SelectType,
    selectedTeam: Binding<BaseballTeam>
  ) {
    self.type = type
    self._selectedTeam = selectedTeam
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text(type.title)
        .font(.caption)
        .foregroundStyle(.gray)
      selectedTeam
        .image
        .resizable()
        .scaledToFit()
      
      HStack {
        Picker(
          "",
          selection: $selectedTeam,
          content: {
            if case let .vs(myteam) = type {
              ForEach(BaseballTeam.allCases.filter{ $0 != myteam }, id: \.self) { team in
                HStack {
                  Text(team.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                  Spacer()
                }
              }
            } else {
              ForEach(BaseballTeam.allCases, id: \.self) { team in
                HStack {
                  Text(team.name)
                    .font(.subheadline)
                    .foregroundStyle(.gray)
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

extension SelectTeamBlock {
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
  SelectTeamBlock(
    type: .my,
    selectedTeam: .constant(.doosan)
  )
}

