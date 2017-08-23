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
    
    let pathToHTMLTemplate = Bundle.main.path(forResource: "pdf_1", ofType: "html")
    let pathToHTMLTemplate1 = Bundle.main.path(forResource: "pdf_2", ofType: "html")
    var pdfFilename: String!
    var tree : Tree?
    
    
    override init() {
        super.init()
    }
    
    func renderPage1() -> String! {
        // Store the invoice number for future use.
       // self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate!)
            
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            if tree?.image != nil {
               
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
            }
            
            var test = tree
    
            HTMLContent = HTMLContent.replacingOccurrences(of: "info0#", with: (tree?.info0)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info1#", with: (tree?.info1)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info2#", with: (tree?.info2)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info3#", with: (tree?.info3)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info4#", with: (tree?.info4)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info5#", with: (tree?.info5)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info6#", with: (tree?.info6)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info7#", with: (tree?.info7)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info8#", with: (tree?.info8)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info9#", with: (tree?.info9)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info10#", with: (tree?.info10)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "info11#", with: (tree?.info11)!)
            
            
            if tree?.environment6 == "Ja" {
                HTMLContent = replaceFirstOfThree(parameterName: "environment6#", HTMLContent: HTMLContent)
            } else if tree?.environment6 == "Nein" {
                HTMLContent = replaceSecondOfThree(parameterName: "environment6#", HTMLContent: HTMLContent)
            }
            else if tree?.environment6 == "Nein" {
                HTMLContent = replaceThirdOfThree(parameterName: "environment6#", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfThree(parameterName: "environment6#", HTMLContent: HTMLContent)
            }

            
            if tree?.info12 == "Jugend" {
                HTMLContent = replaceFirstOfThree(parameterName: "info12", HTMLContent: HTMLContent)
            } else if tree?.info12 == "Reife" {
                HTMLContent = replaceSecondOfThree(parameterName: "info12", HTMLContent: HTMLContent)
            }
            else if tree?.info12 == "Alterung" {
                HTMLContent = replaceThirdOfThree(parameterName: "info12", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfThree(parameterName: "info12", HTMLContent: HTMLContent)
            }
            if tree?.info13 == "Gering" {
                HTMLContent = replaceFirstOfThree(parameterName: "info13", HTMLContent: HTMLContent)
            } else if tree?.info13 == "Hoch" {
                HTMLContent = replaceSecondOfThree(parameterName: "info13", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfThree(parameterName: "info13", HTMLContent: HTMLContent)
            }
            if tree?.info14 == "Gesund/leicht geschädigt" {
                HTMLContent = replaceFirstOfThree(parameterName: "info14", HTMLContent: HTMLContent)
            } else if tree?.info14 == "Stärker geschädigt" {
                HTMLContent = replaceSecondOfThree(parameterName: "info14", HTMLContent: HTMLContent)
            }
            else {
                HTMLContent = replaceEmptyOfThree(parameterName: "info14", HTMLContent: HTMLContent)
            }
            
            if tree?.care0 == "sofort" {
                HTMLContent = replaceFirstOfThree(parameterName: "care0", HTMLContent: HTMLContent)
            } else if tree?.care0 == "dieses Jahr" {
                HTMLContent = replaceSecondOfThree(parameterName: "care0", HTMLContent: HTMLContent)
            }
            else if tree?.care0 == "bis zur näcsht. Kontrolle" {
                HTMLContent = replaceThirdOfThree(parameterName: "care0", HTMLContent: HTMLContent)
            }else if tree?.care0 == "langfristig" {
                HTMLContent = replaceFourthOfThree(parameterName: "care0", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfThree(parameterName: "care0", HTMLContent: HTMLContent)
            }
            
            if tree?.care14 == "sofort" {
                HTMLContent = replaceFirstOfThree(parameterName: "care14", HTMLContent: HTMLContent)
            } else if tree?.care14 == "dieses Jahr" {
                HTMLContent = replaceSecondOfThree(parameterName: "care14", HTMLContent: HTMLContent)
            }
            else if tree?.care14 == "bis zur näcsht. Kontrolle" {
                HTMLContent = replaceThirdOfThree(parameterName: "care14", HTMLContent: HTMLContent)
            }else if tree?.care14 == "langfristig" {
                HTMLContent = replaceFourthOfThree(parameterName: "care14", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfThree(parameterName: "care14", HTMLContent: HTMLContent)
            }
            
            
            if( tree?.care1 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care1#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care1#", with: "☐")}
            if( tree?.care2 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care2#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care2#", with: "☐")}
            if( tree?.care3 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care3#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care3#", with: "☐")}
            if( tree?.care4 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care4#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care4#", with: "☐")}
            if( tree?.care5 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care5#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care5#", with: "☐")}
            if( tree?.care6 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care6#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care6#", with: "☐")}
            if( tree?.care7 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care7#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care7#", with: "☐")}
            if( tree?.care8 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care8#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care8#", with: "☐")}
            if( tree?.care9 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care9#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care9#", with: "☐")}
            if( tree?.care10 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care10#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care10#", with: "☐")}
            if( tree?.care11 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care11#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care11#", with: "☐")}
            if( tree?.care12 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care12#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care12#", with: "☐")}
            if( tree?.care13 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care13#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care13#", with: "☐")}
            
            if( tree?.care15 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care15#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care15#", with: "☐")}
            if( tree?.care16 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care16#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care16#", with: "☐")}
            if( tree?.care17 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care17#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care17#", with: "☐")}
            if( tree?.care18 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care18#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care18#", with: "☐")}
            if( tree?.care19 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care19#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care19#", with: "☐")}
            if( tree?.care20 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care20#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care20#", with: "☐")}
            if( tree?.care21 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care21#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care21#", with: "☐")}
            if( tree?.care22 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care22#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care22#", with: "☐")}
            if( tree?.care23 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care23#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care23#", with: "☐")}
            if( tree?.care24 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care24#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care24#", with: "☐")}
            
            
            if tree?.care28 == "Seilklettertechnik" {
                HTMLContent = replaceFirstOfThree(parameterName: "care28", HTMLContent: HTMLContent)
            } else if tree?.care28 == "Hubarbeitsbühne" {
                HTMLContent = replaceSecondOfThree(parameterName: "care28", HTMLContent: HTMLContent)
            }
            else {
                HTMLContent = replaceEmptyOfThree(parameterName: "care28", HTMLContent: HTMLContent)
            }

            
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    func replaceFirstOfThree(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        return HTMLContent
    }
    func replaceSecondOfThree(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        return HTMLContent
    }
    func replaceThirdOfThree(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        return HTMLContent
    }
    func replaceFourthOfThree(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☒")
        return HTMLContent
    }
    func replaceEmptyOfThree(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        return HTMLContent
    }
    
    func renderPage2() -> String! {
        // Store the invoice number for future use.
        // self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate1!)
            
            
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
        let printFormatter = UIMarkupTextPrintFormatter(markupText: renderPage2())
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 1)

        printPageRenderer.drawPage(at: 1, in: UIGraphicsGetPDFContextBounds())

        UIGraphicsEndPDFContext()
        
        return data
    }
    
}
