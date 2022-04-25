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
    @IBOutlet weak var imagePickerView: UIImageView!
    
    // MARK: - Properties
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
    var meme = Meme()
    
    // MARK: - Lifecycle methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cameraBtn.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureTextField(topText, "Top")
        configureTextField(bottomText, "Bottom")
        
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
            meme.addTopTextField(text)
        }
        if let text = bottomText.text {
            meme.addBottomTextField(text)
        }
        
    }
    // MARK: - Actions
    @IBAction func sharePressed(_ sender: Any) {
        
        let items = [meme.build(view, navigationController)]
        
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
                                            Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                self.meme.save()
                return
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        present(ac, animated: true)
        
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
        view.endEditing(true)
        meme.reset()
        updateModel()
        topText.text = ""
        bottomText.text = ""
        imagePickerView.image = nil
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
    func configureTextField(_ textField: UITextField, _ placeholder: String) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: memeTextAttributes)

    }



}

