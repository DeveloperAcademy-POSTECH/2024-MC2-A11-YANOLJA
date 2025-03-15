//
//  Array<RecordModel> + FilteredOptions.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

extension Array<RecordModel> {
  func filtered(options: RecordFilter) -> Self {
    switch options {
    case .all:
      return self
    case .teamOptions(let fullName):
      return self.filter { $0.vsTeam.contains(fullName: fullName) }
    case .stadiumsOptions(let fullName):
      return self.filter { $0.stadium.contains(fullName: fullName) }
    case .resultsOptions(let gameResult):
      return self.filter { $0.result == gameResult }
    }
  }
}
