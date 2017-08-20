//
//  PDFViewController.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 11.08.17.
//
//

import UIKit

class PDFViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var treeInfo: [String: AnyObject]!
    //var htmlComposer: TreeComposer!
    var HTMLContent: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     func createInputAsHTML() {
     htmlComposer = TreeComposer()
     if let treeHTML = htmlComposer.renderInvoice(invoiceNumber: treeInfo["invoiceNumber"] as! String,
     invoiceDate: treeInfo["invoiceDate"] as! String,
     recipientInfo: treeInfo["recipientInfo"] as! String,
     items: treeInfo["items"] as! [[String: String]],
     totalAmount: treeInfo["totalAmount"] as! String) {
     
     webView.loadHTMLString(treeHTML, baseURL: NSURL(string: htmlComposer.pathToInvoiceHTMLTemplate!)! as URL)
     HTMLContent = treeHTML
     }
     }
     
     
     /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
     */
}
