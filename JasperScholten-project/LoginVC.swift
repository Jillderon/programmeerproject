//
//  LoginVC.swift
//  JasperScholten-project
//
//  Created by Jasper Scholten on 10-01-17.
//  Copyright © 2017 Jasper Scholten. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    // MARK: - Constants and variables
    let ref = FIRDatabase.database().reference(withPath: "Users")
    
    // MARK: - Outlets
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Met de hulp van Dax
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            
            ref.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.hasChildren() {
                    
                    let userData = User(snapshot: snapshot)
                    
                    if userData.accepted! {
                        print("INGELOGD")
                        self.performSegue(withIdentifier: "loginUser", sender: nil)
                        self.emptyTextfield()
                    } else {
                        print("NIET GEACCEPTEERD")
                    }
                }
            })
        } else {
            print("NIET INGELOGD")
        }
        
        keyboardActions()
    }
    
    // MARK: - Actions
    
    @IBAction func loginUser(_ sender: Any) {
        
        // Retrieve data from Firebase.
        ref.observe(.value, with: { snapshot in
            for item in snapshot.children {
                let userData = User(snapshot: item as! FIRDataSnapshot)
                
                if userData.email == self.mail.text! {
                    if userData.accepted == true {
                        
                        FIRAuth.auth()!.signIn(withEmail: self.mail.text!,
                                               password: self.password.text!) { (user, error) in
                                                if error != nil {
                                                    self.alertSingleOption(titleInput: "Foute invoer", messageInput: "Het emailadres of wachtwoord dat je hebt ingevoerd is incorrect.")
                                                    self.emptyTextfield()
                                                } else {
                                                    self.performSegue(withIdentifier: "loginUser", sender: nil)
                                                    self.emptyTextfield()
                                                }
                        }
                    } else {
                        self.alertSingleOption(titleInput: "Geen toegang", messageInput: "Het verzoek dat je hebt ingediend bij je werkgever, is nog niet geaccepteerd. Probeer het later nog een keer en/of neem contact op met je leidinggevende.")
                        self.emptyTextfield()
                    }
                }
            }
        })
    }
    
    @IBAction func registerUser(_ sender: Any) {
        
        let alert = UIAlertController(title: "Registreren",
                                      message: "Wil je je als medewerker aanmelden bij een bestaande organisatie, of ben je nieuw bij deze app en ga je het gebruiken voor een nieuwe organisatie?",
                                      preferredStyle: .alert)
        
        let employeeAction = UIAlertAction(title: "Medewerker",
                                       style: .default) { action in
                                        self.performSegue(withIdentifier: "employeeRegistration", sender: nil)
        }
        
        let organisationAction = UIAlertAction(title: "Organisatie",
                                         style: .default) { action in
                                            self.performSegue(withIdentifier: "organisationRegistration", sender: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Annuleren",
                                         style: .default)
        
        alert.addAction(employeeAction)
        alert.addAction(organisationAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    func emptyTextfield() {
        self.mail.text! = ""
        self.password.text! = ""
    }
    
    // MARK: - Keyboard actions [2, 3]
    
    func keyboardActions() {
        // Make sure all buttons and inputfields keep visible when the keyboard appears. [2]
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Enable user to dismiss keyboard by tapping outside of it. [3]
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                self.view.frame.origin.y -= (keyboardSize.height)/3
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0 {
                self.view.frame.origin.y += (keyboardSize.height)/3
            }
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

// MARK: - References

/*
 2. http://stackoverflow.com/questions/26070242/move-view-with-keyboard-using-swift
 3. http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
 */

