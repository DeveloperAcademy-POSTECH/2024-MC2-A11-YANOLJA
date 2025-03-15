//
//  SelectTeamView.swift
//  Yanolja
//
//  Created by Guisik Han on 5/20/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct SelectTeamBlock: View {
  @Binding var selectedTeamSymbol: String
  let baseballTeams: [BaseballTeamModel]
  let year: String
  private let type: SelectType
  
  init(
    type: SelectType,
    baseballTeams: [BaseballTeamModel],
    year: String,
    selectedTeamSymbol: Binding<String>
  ) {
    self.type = type
    self.baseballTeams = baseballTeams
    self.year = year
    self._selectedTeamSymbol = selectedTeamSymbol
  }
  
  var body: some View {
    VStack(spacing: 0) {
      Text(type.title)
        .font(.caption)
        .foregroundStyle(.gray)
      Image("\(self.selectedTeamSymbol)")
        .resizable()
        .scaledToFit()
      
      HStack {
        Picker(
          "",
          selection: .init(
            get: {
              baseballTeams.map{ $0.symbol}.contains(selectedTeamSymbol) ? selectedTeamSymbol : (baseballTeams.first ?? .dummy).symbol
            },
            set: { selectedTeamSymbol = $0 }
          ),
          content: {
            ForEach(baseballTeams, id: \.id) { team in
              HStack {
                Text(team.name(year: year, type: .full))
                  .font(.subheadline)
                  .foregroundStyle(.gray)
                Spacer()
              }
              .tag(team.symbol)
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
  SelectTeamBlock(
    type: .vs,
    baseballTeams: [],
    year: "2015",
    selectedTeamSymbol: .constant(BaseballTeamModel.dummy.symbol)
  )
}

