//
//  ViewController.swift
//  Homework2
//
//  Created by Consultant on 1/31/22.
//

import UIKit
internal var array = [Nasa.NasaPhotos]()
private var networkManager = NetworkManager()
internal var random = Nasa(photos: array)

internal var row = 0
class ViewController: UIViewController, UITableViewDelegate {

   
    @IBOutlet private weak var tblView: UITableView!
    
    internal var favArray = [Int]()
    override func viewDidLoad() {
    
        tblView.dataSource = self
        tblView.delegate = self
        super.viewDidLoad()
            
         }
    
 
    }

    private func fetchNasa(){
        networkManager.getPhotos(from: NetworkURLs.baseURL){result in
        switch result {
        case .success(let response):
            array = response.photos
            random = response
    //        print(array[1].id) // troubleshooting
        case.failure(let error):
            print(error.localizedDescription)
        }
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   return array.count  // troubleshooting
        fetchNasa()
        sleep(1) //I hate doing this there is a better way to force the table to load after the fetch im just missing it
        return array.count
    }
    func tableView(_ tableview: UITableView, didSelectRowAt indexPath :IndexPath){
        row = indexPath.row
   //     print(row) troubleshooting
        self.performSegue(withIdentifier: "nasaSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nasaSegue"{
            if let destVC = segue.destination as? NasaViewController{
                destVC.nasaPic = array[row].img_src
                destVC.nasaRow = row
                destVC.nasaFavArray = favArray
                
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = "ID: \(array[indexPath.row].id)"
            if favArray.contains(indexPath.row){
                cell.detailTextLabel?.text = "Favorated"
           //     print(favArray) //troubleshooting
            }
            else{
                cell.detailTextLabel?.text = "false"
            }
            return cell
    }
}
