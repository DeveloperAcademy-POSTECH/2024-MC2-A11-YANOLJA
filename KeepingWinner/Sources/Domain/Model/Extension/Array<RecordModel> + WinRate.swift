//
//  Array<RecordModel> + WinRate.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

extension Array<RecordModel> {
  var winRate: Int? {
    let totalGames = self.filter { $0.result != .cancel }.count // 취소를 제외한 경기 중 무승부를 포함한 전체 게임 수
    let drawCount = self.filter { $0.result == .draw}.count // 무승부 수
    let winCount = self.filter { $0.result == .win}.count // 이긴 게임 수
    let winOrLoseGamesCount = totalGames - drawCount // 무승부를 제외한 전체 게임 수

    if winOrLoseGamesCount > 0 {
      return Int(Double(winCount) / Double(winOrLoseGamesCount) * 100)
    } else {
      return nil
    }
  }
}
