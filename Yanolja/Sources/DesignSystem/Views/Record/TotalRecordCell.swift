//
//  TotalRecordCell.swift
//  Yanolja
//
//  Created by 유지수 on 10/3/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import SwiftUI

struct TotalRecordCell: View {
  @Bindable var winRateUseCase: WinRateUseCase
  @Bindable var userInfoUseCase: UserInfoUseCase
  @Bindable var recordUseCase: RecordUseCase
  
  var body: some View {
    VStack {
      HStack() {
        VStack(alignment: .leading, spacing: 0) {
          Text("총 \(recordUseCase.state.recordList.count)경기")
            .font(.footnote)
          Spacer()
            .frame(height: 8)
            .frame(maxWidth: .infinity)
          HStack(spacing: 6) {
            Text("\(winRateUseCase.state.myWinCount)승")
            Text("\(winRateUseCase.state.myLoseCount)패")
            Text("\(winRateUseCase.state.myDrawCount)무")
          }
          .font(.title)
          .bold()
        }
        Spacer()
        RecordFaceView(
          characterModel: .init(
            myTeam: userInfoUseCase.state.myTeam,
            totalWinRate: winRateUseCase.state.myWinRate.totalWinRate
          )
        )
        .frame(width: 120, height: 120)
        .offset(x: 10, y: 23)
      }
    }
    .padding(.leading, 16)
    .padding(.vertical, 16)
    .background (
      RoundedRectangle(cornerRadius: 14)
        .stroke(style: StrokeStyle(lineWidth: 0.33))
        .foregroundStyle(.gray)
        .frame(height: 92)
    )
    .frame(height: 92)
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
}

#Preview {
  TotalRecordCell(
    winRateUseCase: .init(
      recordService: RecordDataService(),
      myTeamService: UserDefaultsService()
    ),
    userInfoUseCase: UserInfoUseCase(
      myTeamService: UserDefaultsService(),
      myNicknameService: UserDefaultsService(),
      changeIconService: ChangeAppIconService()
    ), 
    recordUseCase: .init(recordService: RecordDataService())
  )
}
