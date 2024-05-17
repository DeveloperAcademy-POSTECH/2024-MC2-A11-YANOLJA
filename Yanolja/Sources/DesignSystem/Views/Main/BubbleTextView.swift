//
//  BubbleTextView.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import SwiftUI

struct BubbleTextView: View {
  let text: String
  var body: some View {
    VStack {
      Text(text)
        .lineLimit(1)
        .font(.footnote)
        .padding(.horizontal, 25)
        .padding(.vertical, 7)
        .frame(minWidth: 220)
        .background(
          RoundedRectangle(cornerRadius: 17.5)
            .foregroundStyle(
              .brandColor
            )
        )
    }
    .overlay(
      alignment: .bottom,
      content: {
        YanoljaAsset.bubbleEdge.swiftUIImage
          .resizable()
          .scaledToFit()
          .frame(height: 23)
      }
    )
  }
}

#Preview {
  VStack(spacing: 50) {
    HStack {
      Spacer()
        .frame(width: 50)
      Text("사용 예시")
        .font(.largeTitle)
        .bold()
      Spacer()
    }
    BubbleTextView(text: "직관을 기록하고 나의 승리 기여도를 확인하세요")
    BubbleTextView(text: "최소길이")
  }
}
