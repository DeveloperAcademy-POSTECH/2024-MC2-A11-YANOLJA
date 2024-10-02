//
//  RecordDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation

// MARK: - v1.0 이후 에디꺼
struct RecordDataService: RecordDataServiceInterface {
  func readAllRecord() -> Result<[GameRecordWithScoreModel], any Error> {
    return .success([])
  }
  
  func saveRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, any Error> {
    return .success(.init())
  }
  
  func editRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, any Error> {
    return .success(.init())
  }
  
  func removeRecord(id: UUID) -> Result<VoidResponse, any Error> {
    return .success(.init())
  }
}
