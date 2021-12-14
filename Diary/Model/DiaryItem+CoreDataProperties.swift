//
//  DiaryItem+CoreDataProperties.swift
//  Diary
//
//  Created by 副山俊輔 on 2021/12/13.
//
//

import Foundation
import CoreData


extension DiaryItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryItem> {
        return NSFetchRequest<DiaryItem>(entityName: "DiaryItem")
    }

    @NSManaged public var diaryContent: String?
    @NSManaged public var diaryDate: Date?
    @NSManaged public var data: DiaryItem?

}

extension DiaryItem : Identifiable {

}
