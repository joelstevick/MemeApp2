//
//  CollectionViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var memes = Memes.shared
    
    @IBAction func unwindToCollectionView(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
