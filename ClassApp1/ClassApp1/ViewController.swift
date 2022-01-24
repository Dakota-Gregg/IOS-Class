//
//  ViewController.swift
//  ClassApp1
//
//  Created by Consultant on 1/23/22.
//

import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak private var txtString2: UITextField!
    @IBOutlet weak private var txtString1: UITextField!
    @IBOutlet weak private var lblOutput: UILabel!
    @IBAction func btnRun(_ sender: Any) {
        guard let stringA=txtString1.text
                
        else { return }
        let letters=CharacterSet(charactersIn: stringA)
        let comparisonString = txtString2.text
        if comparisonString?.rangeOfCharacter(from:letters) != nil{
            lblOutput.text="Yes"
        }
        else{
            lblOutput.text="No"
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

