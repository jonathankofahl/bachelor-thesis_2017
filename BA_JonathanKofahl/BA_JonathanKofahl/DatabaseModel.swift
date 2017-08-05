//
//  DatabaseConnectionObject.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 01.08.17.
//
// Based on Ralf Eberts Tutorial on Core Data -> iOS Book
//

import UIKit
import Foundation
import CoreData

class DatabaseModel: NSObject {

    let defaults = UserDefaults.standard
    
    private let managedObjectContext : NSManagedObjectContext
    
    init(managedObjectContext : NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
        super.init()
    }

    var trees : [Tree] {
        let request : NSFetchRequest<Tree> = Tree.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "treeNumber", ascending: true)]
        return try! managedObjectContext.fetch(request)
    }
    
    var places : [Place] {
        let request : NSFetchRequest<Place> = Place.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        return try! managedObjectContext.fetch(request)
    }
    
    @discardableResult func createTree(
        // parameters for Tree
        number: Int16,
        info0: String,
        info1: String,
        info2: String,
        info3: String,
        info4: String,
        image: NSData,
        place: Place
        
        
        ) -> Tree {
        let tree = NSEntityDescription.insertNewObject(forEntityName: Tree.entityName, into: self.managedObjectContext) as! Tree
        tree.treeNumber = number
        tree.info0 = info0
        tree.info1 = info1
        tree.info2 = info2
        tree.info3 = info3
        tree.info4 = info4
        tree.image = image
        tree.place = place
        return tree
    }
    
    @discardableResult func createTree(
        ) -> Tree {
        let tree = NSEntityDescription.insertNewObject(forEntityName: Tree.entityName, into: self.managedObjectContext) as! Tree
        tree.treeNumber = Int16(defaults.integer(forKey: "treeCount"))
        defaults.set(Int16(defaults.integer(forKey: "treeCount")), forKey: "treeCount")
        return tree
    }
    
    @discardableResult func createPlace(name: String) -> Place {
       let place = NSEntityDescription.insertNewObject(forEntityName: Place.entityName, into: self.managedObjectContext) as! Place
        place.name = name
        return place
    }
    
    func deleteTree(index: Int) -> Void {
        for (count,tree) in trees.enumerated() {
            if Int(tree.treeNumber) == index {
                managedObjectContext.delete(trees[count])
                 print("deleted a tree")
            }
        }
    }
    
    func deletePlace(index: Int) -> Void {
        //TODO: Delete all trees with this place
        for (index1,tree) in trees.enumerated() {
            if tree.place == places[index] {
                print(index1.description)
                managedObjectContext.delete(tree)
            }
        }
        managedObjectContext.delete(places[index])
    }
    
    func logModel() {
        for tree in trees {
            NSLog("%@", "Tree \(tree.treeNumber)")
        }
    }
    
    func save() {
        assert(Thread.isMainThread)
        do {
            try self.managedObjectContext.save()
        }
        catch let error {
            NSLog("%@", "An error occurred when saving: \(error)")
        }
    }
    
    func clear() {
        self.trees.forEach(self.managedObjectContext.delete)
        save()
    }
    
}

private let coreData = try! CoreData(sqliteDocumentName: "BA_JonathanKofahl.db", schemaName:"BA_JonathanKofahl")
let databaseModel = DatabaseModel(managedObjectContext:coreData.createManagedObjectContext())
