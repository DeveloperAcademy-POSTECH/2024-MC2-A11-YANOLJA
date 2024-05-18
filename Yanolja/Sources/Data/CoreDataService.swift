//
//  CoreDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 5/13/24.
//  Copyright © 2024 com.mc2.yanolja. All rights reserved.
//

import CoreData
import Foundation

// MARK: - 에디꺼
/// Service: 코어 데이터에 접근하는 로직이 존재하는 공간
struct CoreDataService: DataServiceInterface {
  private let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "Baseball")
    container.loadPersistentStores { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    }
  }
  
  func saveRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let newRecord = GameRecord(context: context)
    
    newRecord.id = record.id
    newRecord.date = record.date
    newRecord.myTeam = record.myTeam.rawValue
    newRecord.vsTeam = record.vsTeam.rawValue
    newRecord.stadiums = record.stadiums.rawValue
    newRecord.result = record.result.rawValue
    
    do {
      try context.save()
      return .success(VoidResponse())
    } catch {
      return .failure(error)
    }
  }
  
  func readAllRecord() -> Result<[GameRecordModel], Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    
    do {
      let records = try context.fetch(request)
      let gameRecords = records.map { record -> GameRecordModel in
        GameRecordModel(
          id: record.id ?? UUID(),
          date: record.date ?? Date(),
          myTeam: BaseballTeam(rawValue: record.myTeam ?? "") ?? .myTeam,
          vsTeam: BaseballTeam(rawValue: record.vsTeam ?? "") ?? .myTeam,
          stadiums: BaseballStadiums(rawValue: record.stadiums ?? "") ?? .jamsil,
          gameResult: GameResult(rawValue: record.result ?? "") ?? .win
        )
      }
      return .success(gameRecords)
    } catch {
      print(error.localizedDescription)
      return .failure(error)
    }
  }
  
  func editRecord(_ record: GameRecordModel) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", record.id as CVarArg)
    
    do {
      let records = try context.fetch(request)
      if let existingRecord = records.first {
        existingRecord.date = record.date
        existingRecord.myTeam = record.myTeam.rawValue
        existingRecord.vsTeam = record.vsTeam.rawValue
        existingRecord.stadiums = record.stadiums.rawValue
        existingRecord.result = record.result.rawValue
        
        try context.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "래코드가 없습니다."]))
      }
    } catch {
      return .failure(error)
    }
  }
  
  // 레코드 삭제
  func removeRecord(id: UUID) -> Result<VoidResponse, Error> {
    let context = container.viewContext
    let request: NSFetchRequest<GameRecord> = GameRecord.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    do {
      let records = try context.fetch(request)
      if let recordToDelete = records.first {
        context.delete(recordToDelete)
        
        try context.save()
        return .success(VoidResponse())
      } else {
        return .failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "래코드가 없습니다."]))
      }
    } catch {
      return .failure(error)
    }
  }
}

extension CoreDataService {
  static func testLogging(dataService: DataServiceInterface) {
    guard case .success(let list) = dataService.readAllRecord()
    else { print("기존 데이터 불러오기 실패"); return }
    
    print("불러 온 데이터 리스트 \(list)")
    
    var newData = GameRecordModel()
    let id = newData.id
    
    guard case .success = dataService.saveRecord(newData)
    else { print("새로운 데이터 저장 실패"); return }
    print("새로운 데이터 저장 성공")
    
    guard case .success(let list) = dataService.readAllRecord()
    else { print("새로 저장된 데이터 포함 불러오기 실패"); return }
    print("새로 저장된 데이터 포함 불러오기 \(list)")
    
    newData.stadiums = .changwon
    
    guard case .success = dataService.editRecord(newData) else { print("창원으로 구장 변경 변경 실패"); return }
    print("잠실에서 창원으로 변경 요청 성공")
    
    guard case .success(let list) = dataService.readAllRecord()
    else { print("창원 변경 후 데이터 불러오기 실패"); return }
    print("창원 변경 후 불러 온 데이터 리스트 \(list)")
    
    guard case .success(let list) = dataService.removeRecord(id: id)
    else { print("id로 데이터 삭제 실패"); return }
    print("id로 데이터 삭제 요청 성공")
    
    guard case .success(let list) = dataService.readAllRecord()
    else { print("id 데이터 삭제 후 기존 데이터 전부 불러오기 실패"); return }
    print("id 데이터 삭제 후 기존 데이터 전부 불러오기 성공 \(list)")
  }
}
