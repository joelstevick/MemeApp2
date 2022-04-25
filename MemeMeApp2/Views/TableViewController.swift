//
//  TableViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//


import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var memes = Memes.shared
    
    @IBAction func unwindToTableView(_ unwindSegue: UIStoryboardSegue) {
        print("unwound")
    }
}
    
