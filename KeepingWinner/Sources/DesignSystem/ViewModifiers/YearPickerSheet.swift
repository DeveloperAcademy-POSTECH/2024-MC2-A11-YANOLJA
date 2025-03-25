//
//  YearPickerSheet.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/23/25.
//

import SwiftUI

extension View {
  func yearPickerSheet(
    isPresented: Binding<Bool>,
    selectedYear: String,
    changeYearTo: @escaping (String) -> Void,
    goBackAction: @escaping () -> Void
  ) -> some View {
    self.modifier(
      YearPickerSheetModifier(
        isPresented: isPresented,
        selectedYear: selectedYear,
        changeYearTo: changeYearTo,
        goBackAction: goBackAction
      )
    )
  }
}


struct YearPickerSheetModifier: ViewModifier {
  @Binding var isPresented: Bool
  var selectedYear: String
  var changeYearTo: (String) -> Void
  var goBackAction: () -> Void
  
  func body(content: Content) -> some View {
    content
      .sheet(isPresented: $isPresented) {
        SelectYearContent(
          years: YearFilter.list,
          selectedYear: selectedYear,
          changeYearTo: changeYearTo,
          goBackAction: goBackAction
        )
        .presentationDetents([.height(250)])
      }
  }
}
