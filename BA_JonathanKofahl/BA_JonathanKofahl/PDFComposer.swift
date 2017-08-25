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
    
    //MARK: - Functions create HTML with real Data from the tree
    // Function to replace the placeholders in the pdf_1.html file
    // This will be the first site of the PDF Document
    func renderPage1() -> String! {
        do {
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate!)
            
            // Check if the tree has a image
            if tree?.image != nil {
               
            let image = UIImage(cgImage: (UIImage.init(data: tree?.image! as! Data)?.cgImage)!,
                                scale: 1.0 ,
                                orientation: UIImageOrientation.right)
                
            guard let imageURL = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("tempImage.png") else {
                return nil
            }
            
            // save image to URL
            do {
                try UIImageJPEGRepresentation(image, 1.0)?.write(to: imageURL)
            } catch { }
            // put the image into the HTML Code
            HTMLContent = HTMLContent.replacingOccurrences(of: "#IMAGE", with: imageURL.relativePath )
            }
            
            var test = tree
    
            // Replacing all placeholders in the pdf_1.html file with the Data from the selected tree if there are Values in the tree
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
                HTMLContent = replaceFirstOfSeven(parameterName: "environment6", HTMLContent: HTMLContent)
            } else if tree?.environment6 == "Nein" {
                HTMLContent = replaceSecondOfSeven(parameterName: "environment6", HTMLContent: HTMLContent)
            }
            else if tree?.environment6 == "Unklar" {
                HTMLContent = replaceThirdOfSeven(parameterName: "environment6", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "environment6", HTMLContent: HTMLContent)
            }

            if tree?.info12 == "Jugend" {
                HTMLContent = replaceFirstOfSeven(parameterName: "info12", HTMLContent: HTMLContent)
            } else if tree?.info12 == "Reife" {
                HTMLContent = replaceSecondOfSeven(parameterName: "info12", HTMLContent: HTMLContent)
            }
            else if tree?.info12 == "Alterung" {
                HTMLContent = replaceThirdOfSeven(parameterName: "info12", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "info12", HTMLContent: HTMLContent)
            }
            if tree?.info13 == "Gering" {
                HTMLContent = replaceFirstOfSeven(parameterName: "info13", HTMLContent: HTMLContent)
            } else if tree?.info13 == "Hoch" {
                HTMLContent = replaceSecondOfSeven(parameterName: "info13", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "info13", HTMLContent: HTMLContent)
            }
            if tree?.info14 == "Gesund/leicht geschädigt" {
                HTMLContent = replaceFirstOfSeven(parameterName: "info14", HTMLContent: HTMLContent)
            } else if tree?.info14 == "Stärker geschädigt" {
                HTMLContent = replaceSecondOfSeven(parameterName: "info14", HTMLContent: HTMLContent)
            }
            else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "info14", HTMLContent: HTMLContent)
            }
            
            if tree?.care0 == "sofort" {
                HTMLContent = replaceFirstOfSeven(parameterName: "care0", HTMLContent: HTMLContent)
            } else if tree?.care0 == "dieses Jahr" {
                HTMLContent = replaceSecondOfSeven(parameterName: "care0", HTMLContent: HTMLContent)
            }
            else if tree?.care0 == "bis zur näcsht. Kontrolle" {
                HTMLContent = replaceThirdOfSeven(parameterName: "care0", HTMLContent: HTMLContent)
            }else if tree?.care0 == "langfristig" {
                HTMLContent = replaceFourthOfSeven(parameterName: "care0", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "care0", HTMLContent: HTMLContent)
            }
            
            if tree?.care14 == "sofort" {
                HTMLContent = replaceFirstOfSeven(parameterName: "care14", HTMLContent: HTMLContent)
            } else if tree?.care14 == "dieses Jahr" {
                HTMLContent = replaceSecondOfSeven(parameterName: "care14", HTMLContent: HTMLContent)
            }
            else if tree?.care14 == "bis zur näcsht. Kontrolle" {
                HTMLContent = replaceThirdOfSeven(parameterName: "care14", HTMLContent: HTMLContent)
            }else if tree?.care14 == "langfristig" {
                HTMLContent = replaceFourthOfSeven(parameterName: "care14", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "care14", HTMLContent: HTMLContent)
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
                HTMLContent = replaceFirstOfSeven(parameterName: "care28", HTMLContent: HTMLContent)
            } else if tree?.care28 == "Hubarbeitsbühne" {
                HTMLContent = replaceSecondOfSeven(parameterName: "care28", HTMLContent: HTMLContent)
            }
            else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "care28", HTMLContent: HTMLContent)
            }

            
            //MARK: Care (Weiteres Vorgehen)
            if(false){//if( tree?.care29 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care29#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care29#", with: "☐")}
            if(false){//if( tree?.care30 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care30#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care30#", with: "☐")}
            if(false){//if( tree?.care31 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care31#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care31#", with: "☐")}
            if(false){//if( tree?.care32 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care32#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care32#", with: "☐")}
            if(false){//if( tree?.care33 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care33#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care33#", with: "☐")}
            if(false){//if( tree?.care34 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care34#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care34#", with: "☐")}
            if(false){//if( tree?.care35 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care35#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care35#", with: "☐")}
            if(false){//if( tree?.care36 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care36#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care36#", with: "☐")}
            if(false){//if( tree?.care37 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care37#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care37#", with: "☐")}
            if(false){//if( tree?.care38 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care38#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care38#", with: "☐")}
            
            if(false){//if tree?.care39 == "Seilklettertechnik" {
                HTMLContent = replaceFirstOfSeven(parameterName: "care39", HTMLContent: HTMLContent)
            } else if(false){//if tree?.care39 == "Hubarbeitsbühne" {
                HTMLContent = replaceSecondOfSeven(parameterName: "care39", HTMLContent: HTMLContent)
            } else if(false){//else if tree?.care39 == "Hubarbeitsbühne" {
                HTMLContent = replaceSecondOfSeven(parameterName: "care39", HTMLContent: HTMLContent)
            }
            else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "care39", HTMLContent: HTMLContent)
            }
            
            if(false){//if( tree?.care40 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care40#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care40#", with: "☐")}
            if(false){//if( tree?.care41 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care41#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care41#", with: "☐")}
            if(false){//if( tree?.care42 == "Ja" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care42#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "care42#", with: "☐")}

            
            return HTMLContent
            
        }
        catch {
            print("Cant replace placeholders in pdf_1.html File")
        }
        
        return nil
    }
    
  
    
    func renderPage2() -> String! {
        // Store the invoice number for future use.
        // self.invoiceNumber = invoiceNumber
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToHTMLTemplate1!)
            
            //MARK: Crown
            for i in 0..<15 {
            let str = "crown" + i.description
                print(str)
                if i == 15 {
                } else {
                    if tree?.value(forKey: str) != nil {
                        print(tree?.value(forKey: str))
                        HTMLContent = self.replaceMultipleValues(attribute: str, content: HTMLContent)
                    } else {
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_0", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_1", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_2", with: "☐")
                    }
                }
            }
            
            for i in 21..<27 {
                let str = "crown" + i.description
                print(str)
                if i == 15 {
                } else {
                    if tree?.value(forKey: str) != nil {
                        print(tree?.value(forKey: str))
                        HTMLContent = self.replaceMultipleValues(attribute: str, content: HTMLContent)
                    } else {
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_0", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_1", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_2", with: "☐")
                    }
                }
            }
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "crown17#", with: (tree?.crown17)!)
            HTMLContent = HTMLContent.replacingOccurrences(of: "crown19#", with: (tree?.crown19)!)

            if tree?.crown20 == "leicht" {
                
                HTMLContent = replaceFirstOfSeven(parameterName: "crown20", HTMLContent: HTMLContent)
            } else if tree?.crown20 == "mittel" {
                HTMLContent = replaceSecondOfSeven(parameterName: "crown20", HTMLContent: HTMLContent)
            } else if tree?.crown20 == "schwach" {
                HTMLContent = replaceThirdOfSeven(parameterName: "crown20", HTMLContent: HTMLContent)
            }
            else {
                
                HTMLContent = replaceEmptyOfSeven(parameterName: "crown20", HTMLContent: HTMLContent)
            }
            
            if( tree?.crown16 == "Gefährlich" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "crown16#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "crown16#", with: "☐")}
            
            if( tree?.crown18 == "Gefährlich" ) {
                HTMLContent = HTMLContent.replacingOccurrences(of: "crown18#", with: "☒") } else {
                HTMLContent = HTMLContent.replacingOccurrences(of: "crown18#", with: "☐")}
            
            if tree?.crown15 == 0.0 {
                HTMLContent = replaceFirstOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            } else if tree?.crown15 == 0.5 {
                HTMLContent = replaceSecondOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }
            else if tree?.crown15 == 1.0 {
                HTMLContent = replaceThirdOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }else if tree?.crown15 == 1.5 {
                HTMLContent = replaceFourthOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }else if tree?.crown15 == 2.0 {
                HTMLContent = replaceFiveOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }else if tree?.crown15 == 2.5 {
                HTMLContent = replaceSixOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }else if tree?.crown15 == 3.0 {
                HTMLContent = replaceSevenOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            } else {
                HTMLContent = replaceEmptyOfSeven(parameterName: "crown15", HTMLContent: HTMLContent)
            }
            
            //MARK: Tribe
            for i in 0..<8 {
                let str = "tribe" + i.description
                if i == 8 {
                    
                    print("Jo")
                    
                }
                print(str)
                    if tree?.value(forKey: str) != nil {
                        print(tree?.value(forKey: str))
                        HTMLContent = self.replaceMultipleValues(attribute: str, content: HTMLContent)
                    } else {
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_0", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_1", with: "☐")
                        HTMLContent = HTMLContent.replacingOccurrences(of: str+"_2", with: "☐")
                }
                
            }
            
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "tribe9#", with: (tree?.tribe9)!)
            
            for i in 10..<12 {
                let str = "tribe" + i.description
                print(str)
                if tree?.value(forKey: str) != nil {
                    print(tree?.value(forKey: str))
                    HTMLContent = self.replaceMultipleValues(attribute: str, content: HTMLContent)
                } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_0", with: "☐")
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_1", with: "☐")
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_2", with: "☐")
                }
            }
            
            for i in 13..<21 {
                let str = "tribe" + i.description + "#"
                print(str)
                if( tree?.care21 == "vorhanden" ) {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☒") } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☐")}
            }
            
            HTMLContent = HTMLContent.replacingOccurrences(of: "tribe21#", with: (tree?.tribe21)!)

            for i in 22..<29 {
                let str = "tribe" + i.description + "#"
                print(str)
                if( tree?.care21 == "vorhanden" ) {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☒") } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☐")}
            }
            
            //MARK: Root
            
            for i in 0..<5 {
                let str = "root" + i.description
                print(str)
                if tree?.value(forKey: str) != nil {
                    print(tree?.value(forKey: str))
                    HTMLContent = self.replaceMultipleValues(attribute: str, content: HTMLContent)
                } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_0", with: "☐")
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_1", with: "☐")
                    HTMLContent = HTMLContent.replacingOccurrences(of: str+"_2", with: "☐")
                }
            }

            HTMLContent = HTMLContent.replacingOccurrences(of: "root5#", with: (tree?.root5)!)

            for i in 6..<14 {
                let str = "root" + i.description + "#"
                print(str)
                if( tree?.care21 == "vorhanden" ) {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☒") } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☐")}
            }
            
            //MARK: Environment
            for i in 2..<9{
                let str = "environment" + i.description + "#"
                print(str)
                if( tree?.care21 == "vorhanden" ) {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☒") } else {
                    HTMLContent = HTMLContent.replacingOccurrences(of: str, with: "☐")}
            }
            
            
            // The HTML code is ready.
            return HTMLContent
            
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
    }
    
    //MARK: - Helping methods to replace values in the html more efficiently
    
    func replaceMultipleValues(attribute:String, content: String) -> String {
        var HTMLContent = content
        if tree?.value(forKey: attribute) as! String == "Unbedenklich" {
            HTMLContent = replaceFirstOfSeven(parameterName: attribute, HTMLContent: HTMLContent)
        } else if tree?.value(forKey: attribute) as! String == "Gefährlich" {
            HTMLContent = replaceSecondOfSeven(parameterName: attribute, HTMLContent: HTMLContent)
        }
        else if tree?.value(forKey: attribute) as! String == "Unklar" {
            HTMLContent = replaceThirdOfSeven(parameterName: attribute, HTMLContent: HTMLContent)
        } else {
            HTMLContent = replaceEmptyOfSeven(parameterName: attribute, HTMLContent: HTMLContent)
        }
        
        return HTMLContent

    }
    
    func replaceFirstOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")

        return HTMLContent
    }
    func replaceSecondOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")

        return HTMLContent
    }
    func replaceThirdOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")

        return HTMLContent
    }
    func replaceFourthOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")

        return HTMLContent
    }
    func replaceFiveOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")
        return HTMLContent
    }
    func replaceSixOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☒")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")
        return HTMLContent
    }
    func replaceSevenOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☒")
        return HTMLContent
    }
    func replaceEmptyOfSeven(parameterName: String, HTMLContent: String) -> String {
        var HTMLContent = HTMLContent
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_0", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_1", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_2", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_3", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_4", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_5", with: "☐")
        HTMLContent = HTMLContent.replacingOccurrences(of: parameterName + "_6", with: "☐")
        return HTMLContent
    }

    
    //MARK: - Save the PDF File in a local directory (not iCloud)
    func exportHTMLContentToPDF(HTMLContent: String) {
        var printPageRenderer = CustomPrintPageRenderer()
        
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
        
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
        
        pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/Baum\((tree?.info6)!).pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
        
        print(pdfFilename)
    }
    
    //MARK: - render th HTML into data: we have 2 pages (pdf_1.html & pdf_2.html)
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
        
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
        
        let bounds = UIGraphicsGetPDFContextBounds()
        
        for i in 0...(printPageRenderer.numberOfPages - 1) {
            UIGraphicsBeginPDFPage()
            printPageRenderer.drawPage(at: i, in: bounds)
        }
        
        UIGraphicsEndPDFContext()
        
        return data
    }
    
}
