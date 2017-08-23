//
//  PDFViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 11.08.17.
//
//  based on a Tutorial by AppCoda: https://github.com/appcoda/Print2PDF
//

import UIKit
import MessageUI

class PDFViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    var tree: Tree?
    var pdfComposer: PDFComposer!
    var HTMLContent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInputAsHTML()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        webView.scrollView.contentInset = UIEdgeInsets.zero;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func createInputAsHTML() {
     pdfComposer = PDFComposer()
    pdfComposer.tree = self.tree
        
        if let treeHTML = pdfComposer.renderPage1() {
     
     webView.loadHTMLString(treeHTML, baseURL: NSURL(string: pdfComposer.pathToHTMLTemplate!)! as URL)
     HTMLContent = treeHTML
     pdfComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
     }
     }
   
    @IBAction func iCloudDriveAction(_ sender: Any) {
        pdfComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent)
    }
    @IBAction func emailAction(_ sender: Any) {
        sendEmail()
    }
    
    func sendEmail() {
        
        if MFMailComposeViewController.canSendMail() {
            
            let mailComposeViewController = MFMailComposeViewController()
            mailComposeViewController.mailComposeDelegate = self
            mailComposeViewController.setSubject("Baumkontrolle")
            
            mailComposeViewController.addAttachmentData(((NSData(contentsOfFile: pdfComposer.pdfFilename)!as Data) as Data) as Data, mimeType: "application/pdf", fileName: "Baum" + (tree?.info6)!)
            
            present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    // help delegate func to dismiss the MailView
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }

}
