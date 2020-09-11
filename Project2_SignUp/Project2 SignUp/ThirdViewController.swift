//
//  ThirdViewController.swift
//  Project2 SignUp
//
//  Created by 안유진 on 2020/07/31.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,UIApplicationDelegate {

    @IBOutlet var phoneNumberTextField: UITextField?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var datePicker: UIDatePicker?
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var prevButton: UIButton?
    @IBOutlet var nextButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        nextButton?.isUserInteractionEnabled = false
        nextButton?.setTitleColor(.gray, for: .normal)
        phoneNumberTextField?.addTarget(self, action: #selector(fieldChanged(_:)), for: .editingChanged)
    }
    
    @IBAction func dismissModal(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelModal(){
    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signupModal(){
        UserInformation.user.phoneNumber = phoneNumberTextField?.text
        UserInformation.user.dateOfBirth = dateLabel?.text
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
      }()
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date: Date = self.datePicker!.date
        let dateString: String =  self.dateFormatter.string(from: date)
        self.dateLabel?.text = dateString
    }
    
    @objc func fieldChanged(_ sender: UITextField){
        if phoneNumberTextField?.text?.isEmpty == true {
            nextButton?.isUserInteractionEnabled = false
            nextButton?.setTitleColor(.gray, for: .normal)
           }
           else{
            UserInformation.user.phoneNumber = phoneNumberTextField?.text
            UserInformation.user.dateOfBirth = dateLabel?.text
            nextButton?.isUserInteractionEnabled = true
            nextButton?.setTitleColor(.systemBlue, for: .normal)
           }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
