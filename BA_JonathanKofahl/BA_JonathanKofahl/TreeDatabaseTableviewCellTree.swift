//
//  TreeDatabaseTableviewCellTree.swift
//  BA_JonathanKofahl
//
//  Created by Jonathan Kofahl on 01.08.17.
//
//

import Foundation
import UIKit

class TreeDatabaseTableViewCellTree: UITableViewCell {
    
    @IBOutlet weak var treeNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
}
    
    @IBAction func controlTree(_ sender: Any) {
    }
    
    @IBAction func deleteTree(_ sender: Any) {
    }
    
}
