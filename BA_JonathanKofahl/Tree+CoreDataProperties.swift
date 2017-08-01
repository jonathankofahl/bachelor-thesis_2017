//
//  Tree+CoreDataProperties.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 01.08.17.
//
//

import Foundation
import CoreData


extension Tree {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tree> {
        return NSFetchRequest<Tree>(entityName: "Tree")
    }

    @NSManaged public var info0: String?
    @NSManaged public var info1: String?
    @NSManaged public var info2: String?
    @NSManaged public var info3: String?
    @NSManaged public var info4: String?
    @NSManaged public var treeNumber: Int16
    @NSManaged public var image: NSData?

}
