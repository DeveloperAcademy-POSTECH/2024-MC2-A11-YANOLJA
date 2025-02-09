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
  
  var body: some View {
    Button(
      action: {
        sortByLatestDate.toggle()
    }) {
      Image(systemName: "arrow.up.arrow.down")
        .font(.subheadline)
        .foregroundStyle(.gray)
        .bold()
    }
  }
}

#Preview {
  RecordListOrderButton(sortByLatestDate: .constant(true))
}
