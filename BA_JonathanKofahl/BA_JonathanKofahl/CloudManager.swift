//
//  CloudManager.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 23.08.17.
//
//

import Foundation
import UIKit

class CloudManager{
    
    static let sharedInstance = CloudManager() // Singleton
    
    var localLocation : URL?
    
    struct DocumentsDirectory {
        static let localDocumentsURL: NSURL? = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last! as NSURL
        static var url: NSURL? = FileManager.default.url(forUbiquityContainerIdentifier: nil)! as NSURL
        static let iCloudDocumentsURL: NSURL? = url?.appendingPathComponent("Documents")! as! NSURL
    }
    
    
    // Return the Document directory (Cloud OR Local)
    // To do in a background thread
    
    func getDocumentDiretoryURL() -> NSURL {
        print(DocumentsDirectory.iCloudDocumentsURL)
        print(DocumentsDirectory.localDocumentsURL)
        if isCloudEnabled()  {
            return DocumentsDirectory.iCloudDocumentsURL!
        } else {
            return DocumentsDirectory.localDocumentsURL!
        }
    }
    
    // Return true if iCloud is enabled
    
    func isCloudEnabled() -> Bool {
        if DocumentsDirectory.iCloudDocumentsURL != nil {
            
            return true }
        else {
            print("ICLOUD NOT ENABLED")
            return false }
    }
    
    // Delete All files at URL
    
    func deleteFilesInDirectory(url: NSURL?) {
     /*   let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(atPath: url!.path!)
        while let file = enumerator?.nextObject() as? String {
            
            do {
                try fileManager.removeItem(at: url!.appendingPathComponent(file)!)
                print("Files deleted")
            } catch let error as NSError {
                print("Failed deleting files : \(error)")
            }
        }*/
    }
    
    // Move local files to iCloud
    // iCloud will be cleared before any operation
    // No data merging
    
    func moveFileToCloud(number: String) -> URL {
        if isCloudEnabled() {
           // deleteFilesInDirectory(url: DocumentsDirectory.iCloudDocumentsURL!) // Clear destination
            let fileManager = FileManager.default
            let enumerator = fileManager.enumerator(atPath: DocumentsDirectory.localDocumentsURL!.path!)
           // var file = "\(AppDelegate.getAppDelegate().getDocDir())/Baum\(number!).pdf"
            let file = "Baum\(number).pdf"
               do {
                try fileManager.setUbiquitous(true,itemAt: DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!,destinationURL: DocumentsDirectory.iCloudDocumentsURL!.appendingPathComponent(file)!)
                print(DocumentsDirectory.iCloudDocumentsURL!)
                print("Moved to iCloud")
                localLocation = DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!
                
                
                               } catch let error as NSError {
               // print("Failed deleting files : \(error)")
                print(DocumentsDirectory.iCloudDocumentsURL!)
                print("fehler")
            }
            
            return DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!

        }
        
        var url = URL(fileURLWithPath: "")
        return url

    }
    
    // Move iCloud files to local directory
    // Local dir will be cleared
    // No data merging
    
    func moveFileToLocal() {
        if isCloudEnabled() {
            deleteFilesInDirectory(url: DocumentsDirectory.localDocumentsURL!)
            let fileManager = FileManager.default
            let enumerator = fileManager.enumerator(atPath: DocumentsDirectory.iCloudDocumentsURL!.path!)
            while let file = enumerator?.nextObject() as? String {
                
                do {
                    try fileManager.setUbiquitous(false,
                                                  itemAt: DocumentsDirectory.iCloudDocumentsURL!.appendingPathComponent(file)!,
                                                  destinationURL: DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!)
                    print("Moved to local dir")
                } catch let error as NSError {
                    print("Failed to move file to local dir : \(error)")
                }
            }
        }
    }
    
    
    
}
