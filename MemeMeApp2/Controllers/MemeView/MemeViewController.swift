//
//  MemeViewController.swift
//  MemeMeApp2
//
//  Created by Joel Stevick on 4/24/22.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,  UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var memedImageView: UIView!
    
    // MARK: - Properties
    
    var unwindTarget: String?
    
    let pickerController = UIImagePickerController()
    
    var adjustForKeyboard = false
    
    let bottomTextTag = 2
    
    let cameraBtnTag = 2
    
    var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSAttributedString.Key.strokeWidth:  -5.0 // need to do this so that the foreground color is applied 🤔
    ]
    var meme: Meme?
    var entryId: Int?
    
    var memes = Memes.shared
    
    // MARK: - Lifecycle methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

       
        // the source controller can set a meme that should be updated
        if let meme = meme {
            configureTextField(topText, meme.getTopText(), isUpdate: true)
            configureTextField(bottomText, meme.getBottomText(), isUpdate: true)
            
            imagePickerView.image = meme.getOriginalImage()
            
            updateModel()
            
        } else {
            // new meme
            configureTextField(topText, "Top", isUpdate: false)
            configureTextField(bottomText, "Bottom", isUpdate: false)
            meme = Meme()
        }
        
        // enable buttons based on the presence of a meme
        saveBtn.isEnabled = entryId != nil ? true : false
        shareBtn.isEnabled = entryId != nil ? true : false
        
        
        pickerController.delegate = self
        
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - TextField Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        adjustForKeyboard = textField.tag == bottomTextTag
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        updateModel()
        return false
    }

    func updateModel() {
        if let text = topText.text {
            meme!.addTopTextField(text)
        }
        if let text = bottomText.text {
            meme!.addBottomTextField(text)
        }
        
        saveBtn.isEnabled = meme!.isValid()
        shareBtn.isEnabled = meme!.isValid()
    }
    // MARK: - Actions
    @IBAction func sharePressed(_ sender: Any) {
        
        let items = [meme!.build(memedImageView)]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.meme!.save()
                
                self.addMemeToList()
                
                self.unwind()
                return
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        present(ac, animated: true)
        
    }
    
    @IBAction func saveBtnClicked(_ sender: UIBarButtonItem) {
        
        // need updateModel here since the user is not always required t
        updateModel()
        
        _ = meme!.build(memedImageView)
        
        meme!.save()
        
        addMemeToList()
        
        unwind()
        
        
    }
    @IBAction func imageCaptureBtnPressed(_ sender: UIBarButtonItem) {
        if sender.tag == cameraBtnTag {
            pickerController.sourceType = .camera
        } else {
            pickerController.sourceType = .photoLibrary
        }
       
        present(pickerController, animated: true, completion: nil)
    }
    @IBAction func cancelPressed(_ sender: Any) {
        unwind()
    }
    
    // MARK: - Keyboard adjustments
    @objc func keyboardWillShow(_ notification: Notification) {
        if adjustForKeyboard {
            view.frame.origin.y = -1 * getKeyboardHeight(notification)
        }
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications () {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil )
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil )
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: - Utility functions
    func configureTextField(_ textField: UITextField, _ placeholder: String, isUpdate: Bool) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: memeTextAttributes)
        textField.textAlignment = .center
        
        if (isUpdate) {
            textField.text = placeholder
        }
    }

    func unwind() {
        performSegue(withIdentifier: unwindTarget!, sender: self)
    }
    
    func addMemeToList() {
        if let entryId = entryId {
            memes.replace(entryId: entryId, meme: meme!)
        }else {
            memes.append(meme!)
        }
        
    }


}

