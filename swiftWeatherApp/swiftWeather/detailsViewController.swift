//
//  detailsViewController.swift
//  swiftWeather
//
//  Created by Syed Hyder Rizvi on 7/8/17.
//  Copyright © 2017 Syed Hyder Rizvi. All rights reserved.
//

import UIKit
import CoreLocation

class detailsViewController: UIViewController {

    @IBOutlet weak var tempMinL: UILabel!
    @IBOutlet weak var tempMaxL: UILabel!
    @IBOutlet weak var windSpeedL: UILabel!
    @IBOutlet weak var cloudCoverL: UILabel!
    @IBOutlet weak var dewPointL: UILabel!
    @IBOutlet weak var humidityL: UILabel!
    
    var windSpeed: Double = 0.0
    var cloudCover: Double? = nil
    var humidity: Double? = nil
    var dewPoint: Double? = nil
    var maxTemp: Int = 0
    var minTemp: Int = 0
    
    var locValue = CLLocationCoordinate2D()
    var stringLocation: String? = nil

    var forecastData = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

   //    updateWeatherForLocation(location: "New York")
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = stringLocation
        
        self.tempMinL.text = ("\(self.minTemp) °F")
        self.tempMaxL.text = ("\(self.maxTemp) °F")
        self.windSpeedL.text = ("\(roundDouble(roundTwo: self.windSpeed))")
        self.cloudCoverL.text = ("\(roundDouble(roundTwo: self.cloudCover!))")
        self.dewPointL.text = ("\(roundDouble(roundTwo: self.dewPoint!))")
        self.humidityL.text = ("\(roundDouble(roundTwo: self.humidity!))")

        
    }

    
    @IBAction func unwindSegue(_ sender: Any) {
        performSegue(withIdentifier: "unwind", sender: self)

    }

//    func updateWeatherForLocation (location:String) {
//        CLGeocoder().geocodeAddressString(location) { (placemarks:[CLPlacemark]?, error:Error?) in
//            if error == nil {
//                if (placemarks?.first?.location) != nil {
//                    Weather.forecast(withLocation: self.locValue, completion: { (results:[Weather]?) in
//                        
//                        if let weatherData = results {
//                            self.forecastData = weatherData
//                            self.windSpeed = self.roundDouble(roundTwo: (self.windSpeed))
//                            //--self.dewPoint = self.roundDouble(roundTwo: (self.dewPoint))
//                            self.humidity = self.roundDouble(roundTwo: (self.humidity!))
//                            self.cloudCover = self.roundDouble(roundTwo: (self.cloudCover!))
//
//                            DispatchQueue.main.async {
//                              self.tempMinL.text = ("\(self.minTemp) °F")
//                              self.tempMaxL.text = ("\(self.maxTemp) °F")
//                              self.windSpeedL.text = ("\(self.windSpeed)")
//                              self.cloudCoverL.text = ("\(self.cloudCover!)")
//                              self.dewPointL.text = ("\(self.dewPoint!)")
//                              self.humidityL.text = ("\(self.humidity!)")
//
//                            }
//                            
//                        }
//                        
//                    })
//                }
//            }
//        }
//    }
    
    func roundDouble(roundTwo: Double) -> Double
    {
        let twoDecimals = Double(round(1000*roundTwo)/1000)
        return twoDecimals

    }

}
