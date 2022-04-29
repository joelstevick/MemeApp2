//
//  MemeDetailViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/29/22.
//

import UIKit

class MemeDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var imageView: UIImageView!
    var meme: Meme?
    
    override func viewDidLoad() {
        imageView.image = meme?.getImage()
    }
}
