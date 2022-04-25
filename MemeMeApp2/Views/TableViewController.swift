//
//  TableViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//


import UIKit

// MARK: - ViewController: UIViewController

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var memes = Memes.shared
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeVC" {
            let vc = segue.destination as! MemeViewController
            vc.tableView = tableView
        }
    }
}
    
