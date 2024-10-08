//
//  RecordDataService.swift
//  Yanolja
//
//  Created by 박혜운 on 10/1/24.
//  Copyright © 2024 com.mc2. All rights reserved.
//

import Foundation
import CoreData
import UIKit

// MARK: - v1.0 이후 에디꺼
class RecordDataService: RecordDataServiceInterface {
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Baseball")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // 모든 기록을 불러옵니다
    func readAllRecord() -> Result<[GameRecordWithScoreModel], Error> {
        let recordContext = container.viewContext
        let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
        
        do {
            let fetchedRecords = try recordContext.fetch(fetchRequest)
            let gameRecords = fetchedRecords.map { recordData -> GameRecordWithScoreModel in
                var image: UIImage? = nil
                if let photoData = recordData.photo {
                    image = UIImage(data: photoData) // Data -> UIImage 변환
                }
                
                return GameRecordWithScoreModel(
                    id: recordData.id ?? UUID(),
                    date: recordData.date ?? Date(),
                    stadiums: recordData.stadiums ?? "",
                    myTeam: BaseballTeam(rawValue: recordData.myTeam ?? "") ?? .doosan,
                    vsTeam: BaseballTeam(rawValue: recordData.vsTeam ?? "") ?? .doosan.anyOtherTeam(),
                    isDoubleHeader: Int(recordData.isDoubleHeader),
                    myTeamScore: String(recordData.myTeamScore),
                    vsTeamScore: String(recordData.vsTeamScore),
                    isCancel: recordData.isCancel,
                    memo: recordData.memo,
                    photo: image // UIImage 반환
                )
            }
            return .success(gameRecords)
        } catch {
            return .failure(error)
        }
    }
    
    // 새로운 기록을 저장합니다
    func saveRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, Error> {
        let recordContext = container.viewContext
        let newRecordData = RecordData(context: recordContext)
        
        newRecordData.id = record.id
        newRecordData.date = record.date
        newRecordData.myTeam = record.myTeam.rawValue
        newRecordData.vsTeam = record.vsTeam.rawValue
        newRecordData.myTeamScore = Int32(record.myTeamScore) ?? 0
        newRecordData.vsTeamScore = Int32(record.vsTeamScore) ?? 0
        newRecordData.isCancel = record.isCancel
        newRecordData.isDoubleHeader = Int32(record.isDoubleHeader)
        newRecordData.stadiums = record.stadiums
        newRecordData.memo = record.memo
        
        // UIImage -> Data 변환 후 저장
        if let photo = record.photo {
            newRecordData.photo = photo.jpegData(compressionQuality: 1.0)
        }
        
        do {
            try recordContext.save()
            return .success(VoidResponse())
        } catch {
            return .failure(error)
        }
    }
    
    // 기존의 기록을 수정합니다
    func editRecord(_ record: GameRecordWithScoreModel) -> Result<VoidResponse, Error> {
        let recordContext = container.viewContext
        let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", record.id as CVarArg)
        
        do {
            let results = try recordContext.fetch(fetchRequest)
            if let recordToEdit = results.first {
                // 기존 데이터 수정
                recordToEdit.date = record.date
                recordToEdit.myTeam = record.myTeam.rawValue
                recordToEdit.vsTeam = record.vsTeam.rawValue
                recordToEdit.myTeamScore = Int32(record.myTeamScore) ?? 0
                recordToEdit.vsTeamScore = Int32(record.vsTeamScore) ?? 0
                recordToEdit.isCancel = record.isCancel
                recordToEdit.isDoubleHeader = Int32(record.isDoubleHeader)
                recordToEdit.stadiums = record.stadiums
                recordToEdit.memo = record.memo
                
                // UIImage -> Data 변환 후 저장
                if let photo = record.photo {
                    recordToEdit.photo = photo.jpegData(compressionQuality: 1.0)
                }
                
                try recordContext.save()
                return .success(VoidResponse())
            } else {
                return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
            }
        } catch {
            return .failure(error)
        }
    }
    
    // 기존의 기록을 삭제합니다
    func removeRecord(id: UUID) -> Result<VoidResponse, Error> {
        let recordContext = container.viewContext
        let fetchRequest: NSFetchRequest<RecordData> = RecordData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try recordContext.fetch(fetchRequest)
            if let recordToDelete = results.first {
                recordContext.delete(recordToDelete)
                try recordContext.save()
                return .success(VoidResponse())
            } else {
                return .failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Record not found"]))
            }
        } catch {
            return .failure(error)
        }
    }
}
