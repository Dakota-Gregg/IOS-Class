//
//  NasaViewController.swift
//  Homework2
//
//  Created by Consultant on 2/2/22.
//


import UIKit
class NasaViewController:UIViewController, UITableViewDelegate{
    var nasaPic : String = ""
    var nasaRow : Int = 0
    var nasaFavArray = [Int]()
    @IBOutlet private weak var swFavSwitch: UISwitch!
    @IBAction func swcFavSwitch(_ sender: Any) {
        if nasaFavArray.contains(row){
            nasaFavArray.remove(at: nasaFavArray.firstIndex(of: row)!)
        }
        else{
            
            nasaFavArray.append(nasaRow)
        }
        
    }
    @IBOutlet private weak var imgPics: UIImageView!
    
    override func viewDidLoad() {
        if nasaFavArray.contains(row){
            swFavSwitch.isOn = true
        }
        else{
            swFavSwitch.isOn = false
        }
        print(nasaPic)
        guard let imageData = try? Data(contentsOf: URL(string: nasaPic)!) else{
            return
        }
        print(nasaPic)
        imgPics.image = UIImage(data: imageData)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nasaListseg"{
            if let destVC = segue.destination as? ViewController{
       //         print(nasaFavArray) troubleshooting
                destVC.favArray = nasaFavArray
            }
            
        }
        
    }
}

