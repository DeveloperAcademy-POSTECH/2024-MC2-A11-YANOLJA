//
//  RecordListOrderButton.swift
//  Yanolja
//
//  Created by 박혜운 on 10/8/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct RecordListOrderButton: View {
  @Binding var sortByLatestDate: Bool
  let firstTitle: String
  let secondTitle: String
  
  var body: some View {
    Button(
      action: {
        sortByLatestDate.toggle()
    }) {
      HStack(spacing: 4) {
        Text(sortByLatestDate ? firstTitle : secondTitle)
        Image(systemName: "arrow.up.arrow.down")
      }
      .font(.subheadline)
      .foregroundStyle(.gray)
      .bold()
    }
  }
}

#Preview {
  RecordListOrderButton(
    sortByLatestDate: .constant(true),
    firstTitle: "",
    secondTitle: ""
  )
}
