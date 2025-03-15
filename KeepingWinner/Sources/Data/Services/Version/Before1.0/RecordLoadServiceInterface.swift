//
//  RecordLoadServiceInterface.swift
//  KeepingWinner
//
//  Created by 박혜운 on 3/16/25.
//

import Foundation

protocol RecordLoadServiceInterface {
  func loadRecord() -> Result<[(
    id: UUID,
    date: Date,
    stadiumRawValue: String,
    myTeamSymbol: String,
    vsTeamSymbol: String
  )], Error>
  
  func removeRecord(id: UUID) -> Result<VoidResponse, Error>
}
