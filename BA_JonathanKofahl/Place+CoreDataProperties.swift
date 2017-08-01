//
//  Place+CoreDataProperties.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 01.08.17.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var name: String?

}
