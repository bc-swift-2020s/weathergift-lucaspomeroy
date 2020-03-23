//
//  ViewController.swift
//  WeatherGift
//
//  Created by Lucas  Pomeroy  on 3/22/20.
//  Copyright © 2020 Lucas Pomeroy. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addLocationBarButton: UIBarButtonItem!
    
    var weatherLocations: [WeatherLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var weatherLocation =  WeatherLocation(name: "Chestnut Hill, MA", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        weatherLocation =  WeatherLocation(name: "Uxbridge, MA", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        weatherLocation =  WeatherLocation(name: "Santa Cruz, CA", latitude: 0, longitude: 0)
        weatherLocations.append(weatherLocation)
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing{
                   tableView.setEditing(false, animated: true)
                   sender.title = "Edit"
                   addLocationBarButton.isEnabled = true
               }else{
                   tableView.setEditing(true, animated: true)
                   sender.title = "Done"
                   addLocationBarButton.isEnabled = false
               }
    }
    
    @IBAction func addPressed(_ sender: UIBarButtonItem ) {
       
    }
}
extension LocationListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = weatherLocations[indexPath.row].name
        return cell}
        
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       if editingStyle == .delete{
           weatherLocations.remove(at: indexPath.row)
           tableView.deleteRows(at: [indexPath], with: .fade)
       }
       
   }
   
   func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
       let itemToMove = weatherLocations[sourceIndexPath.row]
       weatherLocations.remove(at: sourceIndexPath.row)
       weatherLocations.insert(itemToMove, at: destinationIndexPath.row)
       
   }
}



