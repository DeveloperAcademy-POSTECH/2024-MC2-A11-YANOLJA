//
//  AnlayzeListFilterButton.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct AnalyticsListFilterButton: View {
  @Binding var selectedRecordGrouping: RecordGrouping
  let groupingOptions: [RecordGrouping]
  
  var body: some View {
    Menu {
      ForEach(groupingOptions, id: \.title) { option in
        GroupingSelectorLabel(
          selectedRecordGrouping: $selectedRecordGrouping,
          recordGrouping: option
        )
      }
    } label: {
      HStack(spacing: 4) {
        Text(selectedRecordGrouping.title)
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
  AnalyticsListFilterButton(
    selectedRecordGrouping: .constant(WeekdayRecordGrouping()),
    groupingOptions: [WeekdayRecordGrouping()]
  )
}
