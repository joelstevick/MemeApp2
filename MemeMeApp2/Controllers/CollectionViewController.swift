//
//  CollectionViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import UIKit

class CollectionViewController: UICollectionViewController {
  
    var memes = Memes.shared
    
    @IBAction func unwindToCollectionView(_ unwindSegue: UIStoryboardSegue) {
        
    }
}
