//
//  SecondViewController.swift
//  Project2 SignUp
//
//  Created by 안유진 on 2020/07/31.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var idTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var checkPasswordTextField: UITextField?
    @IBOutlet var textView: UITextView?
    @IBOutlet var cancel: UIButton?
    @IBOutlet var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let UITapRecognizer = UITapGestureRecognizer(target: self, action: #selector(SecondViewController.touchUpSelectImage(_:)))
        UITapRecognizer.delegate = self
        self.imageView.addGestureRecognizer(UITapRecognizer)
        self.imageView.isUserInteractionEnabled = true
        nextButton?.isUserInteractionEnabled = false
        nextButton?.setTitleColor(.gray, for: .normal)
        checkPasswordTextField?.addTarget(self, action: #selector(fieldChanged(_:)), for: .editingChanged)
    }
    
    @objc func fieldChanged(_ sender: UITextField){
        if idTextField?.text?.isEmpty == false&&passwordTextField?.text?.isEmpty == false&&checkPasswordTextField?.text?.isEmpty == false&&checkPasswordTextField?.text == passwordTextField?.text {
            nextButton?.isUserInteractionEnabled = true
            nextButton?.setTitleColor(.systemBlue, for: .normal)
        }
        else{
            nextButton?.isUserInteractionEnabled = false
            nextButton?.setTitleColor(.gray, for: .normal)
        }
    }
    
    @IBAction func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var imagePicker: UIImagePickerController = {
       let picker: UIImagePickerController = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        return picker
    }()
    
    @objc func touchUpSelectImage(_ sender: Any){
        self.present(self.imagePicker,animated: true, completion: nil)
     }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage: UIImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
           self.imageView.image = originalImage
        }
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func touchUpNextButton(_ sender: UIButton){
        UserInformation.user.name = idTextField?.text
        UserInformation.user.password = passwordTextField?.text
    }
}
