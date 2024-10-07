//
//  RecordDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation
import CoreData

// MARK: - v1.0 이후 에디꺼
struct RecordDataService: RecordDataServiceInterface {
  private let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "Baseball")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  func saveRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, any Error> {
      let recordContext = container.viewContext
      
      let newRecordData = RecordData(context: recordContext)
      
      // 데이터 매핑
      newRecordData.id = record.id
      newRecordData.date = record.date // 전달은 스트링 타입이어서 데이트로 올바르게 변환하는 로직 추가
      newRecordData.myTeam = record.myTeam.rawValue
      newRecordData.vsTeam = record.vsTeam.rawValue
      newRecordData.myTeamScore = Int32(record.myTeamScore) ?? 0
      newRecordData.vsTeamScore = Int32(record.vsTeamScore) ?? 0
      newRecordData.isCancel = record.isCancel
      newRecordData.isDoubleHeader = Int32(record.isDoubleHeader)
      newRecordData.stadiums = record.stadiums.rawValue
      newRecordData.memo = record.memo
      //newRecordData.photo = record.photo?.jpegData(compressionQuality: 1.0) // Image를 UI이미지로 변환하는 코드 추가
      
      do {
          try recordContext.save() // 데이터 저장
          return .success(.init())
      } catch {
          return .failure(error) // 에러 처리
      }
  }
  func readAllRecord() -> Result<[GameRecordWithScoreModel], any Error> {
      let recordContext = container.viewContext
      let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
      
      do {
          let fetchedRecords = try recordContext.fetch(fetchRequest)
          let gameRecords = fetchedRecords.map { recordData -> GameRecordWithScoreModel in
              return GameRecordWithScoreModel(
                  id: recordData.id ?? UUID(),
                  date: recordData.date ?? Date(),
                  stadiums: BaseballStadiums(rawValue: recordData.stadiums ?? "") ?? .gocheok,
                  myTeam: BaseballTeam(rawValue: recordData.myTeam ?? "") ?? .doosan,
                  vsTeam: BaseballTeam(rawValue: recordData.vsTeam ?? "") ?? .doosan.anyOtherTeam(),
                  isDoubleHeader: Int(recordData.isDoubleHeader),
                  myTeamScore: String(recordData.myTeamScore),
                  vsTeamScore: String(recordData.vsTeamScore),
                  isCancel: recordData.isCancel,
                  memo: recordData.memo,
                  photo: nil // 나중에 이미지 로드 방식 구현 예정
              )
          }
          return .success(gameRecords)
      } catch {
          return .failure(error)
      }
  }
  func editRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, any Error> {
      let recordContext = container.viewContext
      let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id == %@", record.id as CVarArg)
      
      do {
          let results = try recordContext.fetch(fetchRequest)
          if let recordToEdit = results.first {
              // 데이터 수정
              recordToEdit.date = record.date
              recordToEdit.myTeam = record.myTeam.rawValue
              recordToEdit.vsTeam = record.vsTeam.rawValue
              recordToEdit.myTeamScore = Int32(record.myTeamScore) ?? 0
              recordToEdit.vsTeamScore = Int32(record.vsTeamScore) ?? 0
              recordToEdit.isCancel = record.isCancel
              recordToEdit.isDoubleHeader = Int32(record.isDoubleHeader)
              recordToEdit.stadiums = record.stadiums.rawValue
              recordToEdit.memo = record.memo
              // recordToEdit.photo = record.photo?.jpegData(compressionQuality: 1.0) // 사진 주석 처리
              
              try recordContext.save()
              return .success(.init())
          } else {
              return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
          }
      } catch {
          return .failure(error)
      }
  }

  func removeRecord(id: UUID) -> Result<VoidResponse, any Error> {
      let recordContext = container.viewContext
      let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
      fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
      
      do {
          let results = try recordContext.fetch(fetchRequest)
          if let recordToDelete = results.first {
              recordContext.delete(recordToDelete)
              try recordContext.save()
              return .success(.init())
          } else {
              return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
          }
      } catch {
          return .failure(error)
      }
  }

}
