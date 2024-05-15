//
//  EditHistoryView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

enum EditType {
  case new
  case edit
}

struct EditHistoryView: View {
  let editType: EditType
  
  init(to editType: EditType) {
    self.editType = editType
  }
  
  var body: some View {
    VStack {
      Text("고스트 꺼")
      Text(editType == .new ? "새 창" : "편집 창")
    }
  }
}

#Preview {
  EditHistoryView(to: .new)
}
