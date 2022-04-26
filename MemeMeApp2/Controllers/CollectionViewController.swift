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
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        collectionView.dataSource = self
    }
    
    // MARK: - Actions
    @IBAction func unwindToCollectionView(_ unwindSegue: UIStoryboardSegue) {
        collectionView.reloadData()
    }
}
