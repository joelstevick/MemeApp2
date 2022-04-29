//
//  ViewController+UIImagePickerControllerDelegate.swift
//  ImagePicker
//
//  Created by Joel Stevick on 4/21/22.
//

import UIKit

extension MemeViewController {
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePickerView.image = info[.originalImage] as? UIImage
        dismiss(animated: true)
        
        meme!.addOriginalImage(imagePickerView.image!)
        
        updateModel()
    }
}
