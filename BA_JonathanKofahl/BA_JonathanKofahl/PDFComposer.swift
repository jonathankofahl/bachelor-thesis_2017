//
//  PDFComposer.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 21.08.17.
// Inspired by Print2PDF Tutorial by Appcoda
// https://github.com/appcoda/Print2PDF
//
//

import Foundation
import UIKit

class PDFComposer: NSObject {
    
    let pathToHTMLTemplate = Bundle.main.path(forResource: "tree", ofType: "html")
    var pdfFilename: String!
    var tree : Tree?
    
    
    override init() {
        super.init()
    }
    
    func renderInvoice() -> String! {
        // Store the invoice number for future use.
       // self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            var image = UIImage(cgImage: (UIImage.init(data: tree?.image! as! Data)?.cgImage)!,
                                scale: 1.0 ,
                                orientation: UIImageOrientation.left)
            // Create a URL in the /tmp directory
            guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("TempImage.png") else {
                return nil
            }
            
            // save image to URL
            do {
                try UIImagePNGRepresentation(image)?.write(to: imageURL)
            } catch { }
            HTMLContent = HTMLContent.replacingOccurrences(of: "#IMAGE", with: imageURL.relativePath )

            
            HTMLContent = HTMLContent.replacingOccurrences(of: "#info0", with: (tree?.info0)!)
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    
    func exportHTMLContentToPDF(HTMLContent: String) {
        let printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Baum\(tree?.info6).pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
        print(pdfFilename)
    }
    
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        UIGraphicsBeginPDFPage()
        
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}
