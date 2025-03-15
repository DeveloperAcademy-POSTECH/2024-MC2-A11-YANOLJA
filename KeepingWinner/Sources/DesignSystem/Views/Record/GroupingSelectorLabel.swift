//
//  FilterLabel.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct GroupingSelectorLabel: View {
  @Binding var selectedRecordGrouping: RecordGrouping
  let recordGrouping: RecordGrouping
  
  var body: some View {
    Button(
      action: {
        selectedRecordGrouping = recordGrouping
      }
    ) {
      HStack {
        if selectedRecordGrouping.title == recordGrouping.title {
          Image(systemName: "checkmark")
        }
        Text(recordGrouping.title)
      }
    }
  }
}

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
