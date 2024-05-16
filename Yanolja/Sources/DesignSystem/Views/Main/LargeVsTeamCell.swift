//
//  LargeVsTeamCell.swift
//  Yanolja
//
//  Created by 박혜운 on 5/17/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

// MARK: - 로셸
struct LargeVsTeamCell: View {
  var body: some View {
    Rectangle()
      .frame(width: 340, height: 105)
      .overlay {
        Text("로셸 꺼")
          .foregroundStyle(.white)
      }
  }
}

#Preview {
  LargeVsTeamCell()
}
