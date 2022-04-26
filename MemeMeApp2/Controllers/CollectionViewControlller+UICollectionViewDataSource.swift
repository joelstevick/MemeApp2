//
//  CollectionViewControlller+UICollectionViewDataSource.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/26/22.
//

import UIKit

extension CollectionViewController {
    
    // MARK: -
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return self.memes.getMemes().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as? MemeCollectionViewCell
        let entry = self.memes.getMemes()[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell!.imageView.image = entry.meme.getImage()
      
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let entry = memes.getMemes()[indexPath.row]
        
        let items = [entry.meme.getImage()]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        present(ac, animated: true)
        
    }
}
