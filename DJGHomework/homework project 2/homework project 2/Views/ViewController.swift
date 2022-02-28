//
//  ViewController.swift
//  homework project 2
//
//  Created by Consultant on 2/14/22.
//

import UIKit
//import Combine
class ViewController: UIViewController {
    public var info: String = ""
    @IBOutlet private weak var btnSaveName: UIButton!
    @IBOutlet private weak var txtNameField: UITextField!
    @IBAction func btnSaveName(_ sender: Any) {
        guard let name = txtNameField.text else{
            return
        }
        UserDefaults.standard.removeObject(forKey: "Name")
        UserDefaults.standard.setValue(name,forKey: "Name")
        txtNameField.text = ""
        performSegue(withIdentifier: "NameToApp", sender: self)
    }
    @IBAction func txtName(_ sender: Any) {
        guard let name = txtNameField.text?.count else{
            return
        }
        if name >= 3 {
            btnSaveName.isEnabled = true
        }
        else {
            btnSaveName.isEnabled = false
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        if (UserDefaults.standard.object(forKey: "Name") != nil && UserDefaults.standard.string(forKey: "Name") != ""){
            performSegue(withIdentifier: "NameToApp", sender: self)
        }    }

  
}

