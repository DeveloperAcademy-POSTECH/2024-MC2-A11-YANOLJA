//
//  SelectYearContent.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/23/25.
//

import SwiftUI

struct SelectYearContent: View {
  @State var selectedYear: String
  let years: [String]
  let changeYearTo: (String) -> Void
  let goBackAction: () -> Void
  
  init(
    years: [String],
    selectedYear: String,
    changeYearTo: @escaping (String) -> Void,
    goBackAction: @escaping () -> Void
  ) {
    self.years = years
    self._selectedYear = .init(initialValue: selectedYear)
    self.changeYearTo = changeYearTo
    self.goBackAction = goBackAction
  }
  
  var body: some View {
    NavigationView {
      VStack(spacing: 0) {
        Picker("연도", selection: $selectedYear) {
          ForEach(years, id: \.self) { year in
            Text(year)
              .tag(year)
          }
        }
        .pickerStyle(.wheel)
        .frame(maxWidth: .infinity, maxHeight: 150)
      }
      .toolbar(
        content: {
          ToolbarItem(placement: .topBarTrailing) {
            Button(
              action: {
                changeYearTo(selectedYear)
                goBackAction()
              },
              label: {
                Text("완료")
                  .bold()
              }
            )
          }
          ToolbarItem(placement: .topBarLeading) {
            Button(
              action: {
                goBackAction()
              },
              label: {
                Text("취소")
              }
            )
          }
        }
      )
      .tint(.black)
      .navigationTitle("연도 선택")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}
