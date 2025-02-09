//
//  FilterLabel.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct RecordFilterLabel: View {
  @Binding var selectedRecordFilter: RecordFilter
  let recordFilter: RecordFilter
  let showLabel: String
  
  var body: some View {
    Button(
      action: {
        selectedRecordFilter = recordFilter
      }
    ) {
      HStack {
        if selectedRecordFilter == recordFilter {
          Image(systemName: "checkmark")
        }
        Text(showLabel)
      }
    }
  }
}

struct AnalyticsFilterLabel: View {
  @Binding var selectedAnalyticsFilter: AnalyticsFilter
  let recordFilter: AnalyticsFilter
  let showLabel: String
  
  var body: some View {
    Button(
      action: {
        selectedAnalyticsFilter = recordFilter
      }
    ) {
      HStack {
        if selectedAnalyticsFilter == recordFilter {
          Image(systemName: "checkmark")
        }
        Text(showLabel)
      }
    }
  }
}
