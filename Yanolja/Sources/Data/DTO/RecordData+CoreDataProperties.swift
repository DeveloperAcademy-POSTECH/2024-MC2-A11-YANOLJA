//
//  RecordData+CoreDataProperties.swift
//  
//
//  Created by jhon on 10/8/24.
//
//

import Foundation
import CoreData


extension RecordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordData> {
        return NSFetchRequest<RecordData>(entityName: "RecordData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var date: String?
    @NSManaged public var myTeam: String?
    @NSManaged public var myTeamScore: Int32
    @NSManaged public var vsTeam: String?
    @NSManaged public var vsTeamScore: Int32
    @NSManaged public var isCancel: Bool
    @NSManaged public var stadiums: String?
    @NSManaged public var isDoubleHeader: Int32
    @NSManaged public var memo: String?
    @NSManaged public var photo: Data?

}
