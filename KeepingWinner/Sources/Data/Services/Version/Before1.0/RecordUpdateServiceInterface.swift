//
//  RecordUpdateServiceInterface.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/14/25.
//

import Foundation

protocol RecordUpdateServiceInterface {
  func saveRecord(
    id: UUID,
    date: Date,
    stadiumSymbol: String,
    isDoubleHeader: Int,
    myTeamSymbol: String,
    vsTeamSymbol: String,
    myTeamScore: String,
    vsTeamScore: String,
    isCancel: Bool) -> Result<VoidResponse, Error>
}
