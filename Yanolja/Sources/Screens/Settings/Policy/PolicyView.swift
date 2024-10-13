//
//  PolicyView.swift
//  Yanolja
//
//  Created by 박혜운 on 10/13/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct PolicyView: View {
  @State var isLoading: Bool = true  // 로딩 상태를 외부에서 바인딩
  let viewType: PolicyType
  var body: some View {
      WebContent(url: viewType.url, isLoading: $isLoading)
        .loadingIndicator(isLoading: isLoading)
  }
}

#Preview {
  PolicyView(viewType: .personalPolicy)
}
