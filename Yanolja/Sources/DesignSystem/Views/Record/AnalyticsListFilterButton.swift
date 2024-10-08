//
//  AnlayzeListFilterButton.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct AnalyticsListFilterButton: View {
  @Binding var selectedAnalyticsFilter: AnalyticsFilter
  
  var body: some View {
    Menu {
      AnalyticsFilterLabel(
        selectedAnalyticsFilter: $selectedAnalyticsFilter,
        recordFilter: .team(.doosan),
        showLabel: AnalyticsFilter.team(.doosan).label
      )
      AnalyticsFilterLabel(
        selectedAnalyticsFilter: $selectedAnalyticsFilter,
        recordFilter: .stadiums(""),
        showLabel: AnalyticsFilter.stadiums("").label
      )
    } label: {
      HStack(spacing: 4) {
        Text(selectedAnalyticsFilter.label)
          .font(.subheadline)
          .foregroundStyle(.gray)
          .bold()
        Image(systemName: "chevron.down")
          .font(.subheadline)
          .foregroundStyle(.gray)
          .bold()
      }
    }
  }
}

#Preview {
  AnalyticsListFilterButton(selectedAnalyticsFilter: .constant(.team(.doosan)))
}
