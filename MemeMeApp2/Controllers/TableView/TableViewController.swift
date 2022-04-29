//
//  TableViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//


import UIKit

class TableViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var tableView: UITableView!
    
    var memes = Memes.shared
    
    // this property is set upon cell selection within the view and is passed to the MemeControllerView
    var selectedMeme: Meme?
    var entryId: Int?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        tabBarController!.delegate = self
        tableView.delegate = self
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeVC" {
            let vc = segue.destination as! MemeViewController
            vc.unwindTarget = "unwindToTableView"
            
            if let selectedMeme = selectedMeme {
                vc.meme = selectedMeme
                vc.entryId = entryId
            }
        }
    }

    // MARK: - Actions
    @IBAction func unwindToTableView(_ unwindSegue: UIStoryboardSegue) {
        tableView.reloadData()
    }
    
}
    
