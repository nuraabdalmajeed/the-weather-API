//
//  ViewController.swift
//  wheatherapp
//
//  Created by nura on 1/26/20.
//  Copyright © 2020 nura. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate {
   //
    let layer = CAGradientLayer()
    let Key = "b0974152e0a98ac50ca0757da5a40c5b "
    var lat = 0.0
    var lng = 0.0
    var activityIndicator: NVActivityIndicatorView!
    let locationManager = CLLocationManager()
    var tt = 0.0
    //View
@IBOutlet weak var citylabel: UILabel!
@IBOutlet weak var daylabel: UILabel!
@IBOutlet weak var resultlabel: UILabel!
@IBOutlet weak var degreelabel: UILabel!
@IBOutlet weak var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    locationManager.requestWhenInUseAuthorization()
    if(CLLocationManager.locationServicesEnabled()){
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.startUpdatingLocation()
        }}
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
let location = locations[0]
lat = location.coordinate.latitude
lng = location.coordinate.longitude
    print(lat )
    print(lng )
let url = "https://api.darksky.net/forecast/b0974152e0a98ac50ca0757da5a40c5b/\(lat),\(lng)"
Alamofire.request(url,method:.get).responseJSON {response in
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    self.daylabel.text = dateFormatter.string(from: date)
    
        do {
            let jsonresult = try JSON(data: response.data!)
          self.citylabel.text = "\( jsonresult["timezone"]))"
        let jsonWeather = jsonresult["currently"]
        let jsonTemp=jsonWeather["temperature"]

        let jsonResult=jsonWeather["summary"]
    self.resultlabel.text = "\(jsonResult)"
            self.tt  = (jsonTemp.doubleValue - 32.0)/(9/5)
            let doubleStr = String(format: "%.2f", self.tt)
            self.degreelabel.text = "\(jsonTemp)℉ ,\(doubleStr)℃"

        }
        catch{
            print("cannot load from server")
}
 
            }}
  
}

