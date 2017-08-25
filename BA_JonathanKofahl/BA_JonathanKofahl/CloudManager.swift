//
//  CloudManager.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 23.08.17.
//  use part of code snippet by: https://stackoverflow.com/questions/33886846/best-way-to-use-icloud-documents-storage
//

import Foundation
import UIKit

class CloudManager{
    
    //MARK: - Variables and Structs
    static let sharedInstance = CloudManager()
    var localLocation : URL?
    struct DocumentsDirectory {
        static let localDocumentsURL: NSURL? = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: .userDomainMask).last! as NSURL
        static var url: NSURL? = FileManager.default.url(forUbiquityContainerIdentifier: nil)! as NSURL
        static let iCloudDocumentsURL: NSURL? = url?.appendingPathComponent("Documents")! as! NSURL
    }
    
    //MARK: - Get the Documents Directory (local or Cloud)
    func getDocumentDiretoryURL() -> NSURL {
        print(DocumentsDirectory.iCloudDocumentsURL)
        print(DocumentsDirectory.localDocumentsURL)
        if isCloudEnabled()  {
            return DocumentsDirectory.iCloudDocumentsURL!
        } else {
            return DocumentsDirectory.localDocumentsURL!
        }
    }
    
    //MARK: - Check if iCloud is reachable
    func isCloudEnabled() -> Bool {
        if DocumentsDirectory.iCloudDocumentsURL != nil {
            
            return true }
        else {
            print("ICLOUD NOT ENABLED")
            return false }
    }
    
    func moveFileToCloud(number: String) -> URL {
        if isCloudEnabled() {
           // deleteFilesInDirectory(url: DocumentsDirectory.iCloudDocumentsURL!) // Clear destination
            let fileManager = FileManager.default
            let enumerator = fileManager.enumerator(atPath: DocumentsDirectory.localDocumentsURL!.path!)
            let file = "Baum\(number).pdf"
               do {
                try fileManager.setUbiquitous(true,itemAt: DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!,destinationURL: DocumentsDirectory.iCloudDocumentsURL!.appendingPathComponent(file)!)
                print(DocumentsDirectory.iCloudDocumentsURL!)
                print("Moved to iCloud")
                localLocation = DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!
                
                
                } catch let error as NSError {
                print(DocumentsDirectory.iCloudDocumentsURL!)
                print("fehler")
            }
            return DocumentsDirectory.localDocumentsURL!.appendingPathComponent(file)!
        }
        
        var url = URL(fileURLWithPath: "")
        return url

    }
    
}
