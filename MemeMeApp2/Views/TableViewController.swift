//
//  TableViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//


import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    
    var memes = Memes.shared
    
    // MARK: - Lifecycle methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeVC" {
            let vc = segue.destination as! MemeViewController
            vc.unwindTarget = "unwindToTableView"
        }
    }

    // MARK: - Actions
    @IBAction func unwindToTableView(_ unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
}
    
