//
//  DataServiceInterface.swift
//  Yanolja
//
//  Created by 박혜운 on 5/15/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import Foundation

protocol RecordDataServiceInterface {
  /// 모든 기록을 불러옵니다
  func readAllRecord(baseballTeams: [BaseballTeamModel], stadiums: [StadiumModel]) -> Result<[RecordModel], Error>
  /// 새로운 기록을 저장합니다
  func saveRecord(_ record: RecordModel) -> Result<VoidResponse, Error>
  /// 기존의 기록을 수정합니다
  func editRecord(_ record: RecordModel) -> Result<VoidResponse, Error>
  /// 기존의 기록을 삭제합니다
  func removeRecord(id: UUID) -> Result<VoidResponse, Error>
}
