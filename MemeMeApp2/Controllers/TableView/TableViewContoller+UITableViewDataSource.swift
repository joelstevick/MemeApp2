//
//  TableViewContoller+UITableViewDataSource.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/25/22.
//

import UIKit

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Protocol implementation
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return self.memes.getMemes().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell") as? MemeCellTableViewCell
        let entry = self.memes.getMemes()[(indexPath as NSIndexPath).row]
        
        // Set the name and image
        cell!.toplabel!.text = entry.meme.getTopText()
        cell!.bottomLabel!.text = entry.meme.getBottomText()
        cell!.imageView!.image = entry.meme.getImage()
      
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let entry = memes.getMemes()[indexPath.row]
        
        selectedMeme = entry.meme
        entryId = entry.id
        
        performSegue(withIdentifier: "MemeVC", sender: self)
        
    }
}
