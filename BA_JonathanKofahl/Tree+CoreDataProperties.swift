//
//  Tree+CoreDataProperties.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 31.07.17.
//
//

import Foundation
import CoreData


extension Tree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tree> {
        return NSFetchRequest<Tree>(entityName: "Tree")
    }

    @NSManaged public var info1: String?
    @NSManaged public var info2: String?
    @NSManaged public var info3: String?
    @NSManaged public var info4: String?
    @NSManaged public var info5: String?
    @NSManaged public var info6: String?
    @NSManaged public var info7: String?
    @NSManaged public var info8: String?
    @NSManaged public var info9: String?
    @NSManaged public var info10: String?
    @NSManaged public var info11: Float
    @NSManaged public var info12: String?
    @NSManaged public var info13: String?
    @NSManaged public var info14: String?
    @NSManaged public var info15: String?
    @NSManaged public var crown1: String?
    @NSManaged public var crown2: String?
    @NSManaged public var info0: String?
    @NSManaged public var crown0: String?
    @NSManaged public var crown3: String?
    @NSManaged public var crown4: String?
    @NSManaged public var crown5: String?
    @NSManaged public var crown6: String?
    @NSManaged public var crown7: String?
    @NSManaged public var crown8: String?
    @NSManaged public var crown9: String?
    @NSManaged public var crown10: String?
    @NSManaged public var crown11: String?
    @NSManaged public var crown12: String?
    @NSManaged public var crown13: String?
    @NSManaged public var crown14: String?
    @NSManaged public var crown15: String?
    @NSManaged public var crown16: String?
    @NSManaged public var crown18: String?
    @NSManaged public var crown19: String?
    @NSManaged public var crown20: String?
    @NSManaged public var crown21: String?
    @NSManaged public var crown22: String?
    @NSManaged public var crown23: String?
    @NSManaged public var crown24: String?
    @NSManaged public var crown25: String?
    @NSManaged public var crown26: String?
    @NSManaged public var treeNumber: Int16

}
