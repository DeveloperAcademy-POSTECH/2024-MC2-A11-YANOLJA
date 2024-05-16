//
//  CoreDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

// MARK: - 에디꺼
/// Service: 코어 데이터에 접근하는 로직이 존재하는 공간
struct CoreDataService: DataServiceInterface {
  func readAllRecord() -> Result<[GameRecordModel], Error> {
    return .success([]) // 임시
  }
  
  func saveRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    return .success(.init()) // 임시
  }
  
  func editRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    return .success(.init()) // 임시
  }
  
  func removeRecord(id: UUID) -> Result<VoidResponse, Error> {
    return .success(.init()) // 임시
  }
}
