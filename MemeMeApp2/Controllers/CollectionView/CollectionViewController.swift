//
//  CollectionViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import UIKit

class CollectionViewController: UIViewController {
  
    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    var memes = Memes.shared
    
    // this property is set upon cell selection within the view and is passed to the MemeControllerView
    var selectedMeme: Meme?
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        collectionView.dataSource = self
        self.tabBarController!.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MemeVC" {
            let vc = segue.destination as! MemeViewController
            vc.unwindTarget = "unwindToCollectionView"
            
            if let selectedMeme = selectedMeme {
                vc.meme = selectedMeme
            }
        }
    }

    
    // MARK: - Actions
    @IBAction func unwindToCollectionView(_ unwindSegue: UIStoryboardSegue) {
        collectionView.reloadData()
    }
}
