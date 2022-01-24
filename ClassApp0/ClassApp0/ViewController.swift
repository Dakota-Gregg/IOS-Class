//
//  ViewController.swift
//  ClassApp0
//
//  Created by Consultant on 1/24/22.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak private var num1a: UITextField!
    @IBOutlet weak private var num1b: UITextField!
    @IBOutlet weak private var num1d: UITextField!
    @IBOutlet weak private var num1c: UITextField!
    @IBOutlet weak private var num1e: UITextField!
    @IBOutlet weak private var num2a: UITextField!
    @IBOutlet weak private var num2b: UITextField!
    @IBOutlet weak private var num2c: UITextField!
    @IBOutlet weak private var num2d: UITextField!
    @IBOutlet weak private var num2e: UITextField!
    
    @IBOutlet weak var lblMatches: UILabel!
    @IBAction func btnCheck(_ sender: Any) {
        let num1=[num1a.text, num1b.text, num1c.text, num1d.text, num1e.text]
        let num2=[num2a.text, num2b.text, num2c.text, num2d.text, num2e.text]
        var matches=0
        for (i) in num1.enumerated(){
            for (j) in num2.enumerated(){
                if i == j{
                    matches=matches+1
                }
            }
        }
        lblMatches.text="\(matches)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

