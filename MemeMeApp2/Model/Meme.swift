//
//  Meme.swift
//  MemeMeApp1
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

struct Meme {
    private var topTextField: String?
    private var bottomTextField: String?
    private var originalImage: UIImage?
    private var memedImage: UIImage?
    
    mutating func addTopTextField(_ topTextField: String)  {
        self.topTextField = topTextField
    }
    
    mutating func addBottomTextField(_ bottomTextField: String) {
        self.bottomTextField = bottomTextField
    }
    
    mutating func addOriginalImage(_ originalImage: UIImage) {
        self.originalImage = originalImage
    }
    
    var hasOriginalImage: Bool {
        return !(originalImage === nil)
    }
    mutating func reset() {
        topTextField = nil
        bottomTextField = nil
        originalImage = nil
    }
    func isValid() -> Bool {
        guard let _ = topTextField,
              let _ = bottomTextField,
              let _ = originalImage else {
            
            return false
        }
        
        return topTextField!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
        && bottomTextField!.trimmingCharacters(in: .whitespacesAndNewlines).count > 0
    }
    mutating func build(_ view: UIView) -> UIImage {
        guard isValid() else {
            fatalError("All properties are required!")
        }
        
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        self.memedImage = memedImage
        
        return memedImage
    }
    
    func save() {
        UIImageWriteToSavedPhotosAlbum(memedImage!, nil, nil, nil)
    }
    
    func getTopText() -> String {
        
        return topTextField!
    }
    
    func getBottomText() -> String {
        return bottomTextField!
    }
    
    func getImage() -> UIImage {
        return memedImage!
    }
    
    func getOriginalImage() -> UIImage {
        return originalImage!
    }
    
}
