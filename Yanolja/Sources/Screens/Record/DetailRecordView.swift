//
//  DetailRecordView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

enum RecordViewEditType {
  case create
  case edit
}

// MARK: - 고스트 꺼
struct DetailRecordView: View {
  let editType: RecordViewEditType
  
  init(to editType: RecordViewEditType) {
    self.editType = editType
  }
  
  var body: some View {
    VStack {
      Text("고스트 꺼")
      Text(editType == .create ? "새 창" : "편집 창")
    }
  }
}

#Preview {
  DetailRecordView(to: .create)
}
