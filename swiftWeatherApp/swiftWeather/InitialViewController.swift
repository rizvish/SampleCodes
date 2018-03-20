//
//  InitialViewController.swift
//  swiftWeather
//
//  Created by Syed Hyder Rizvi on 7/4/17.
//  Copyright © 2017 Syed Hyder Rizvi. All rights reserved.
//

import UIKit
import CoreLocation

var previousLoadLocation:CLLocationCoordinate2D? = nil

class InitialViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var currentLocation: UILabel!
    var loadlocation = CLLocationCoordinate2D()

    @IBOutlet var summaryWeather: UILabel!
    var forecastDavar = [Weather]()
    var forecastCurrent = [WeatherCurrent]()
    
    @IBOutlet weak var descripSmall: UILabel!
    @IBOutlet weak var imgWeather: UIImageView!
    @IBOutlet weak var tempWeather: UILabel!
    var saveSumm: String? = nil
    var tempLocation: String? = nil
    let attachment = NSTextAttachment()
    let locationManager = CLLocationManager()

    var windSpeed: Double = 0.0
    var cloudCover: Double? = nil
    var humidity: Double? = nil
    var dewPoint: Double? = nil
    var maxTemp: Int = 0
    var minTemp: Int = 0
    var previousLatitude = 0.0
    var previousLongitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "JustRightWeather"))
        loadlocation.latitude = 40.7127837
        loadlocation.longitude = -74.00594130000002
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()

            }
        }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if CLLocationManager.locationServicesEnabled() {
            }
    }
 
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    
    {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        convertCoordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        
        loadlocation = CLLocationCoordinate2D(
            latitude: locValue.latitude, longitude: locValue.longitude)
        
        let currentLatitude = roundDouble(roundTwo: Double(loadlocation.latitude))
        let currentLongitude = roundDouble(roundTwo: Double(loadlocation.longitude))

        if(previousLatitude != currentLatitude && previousLongitude != currentLongitude)
        {
       Weather.forecast(withLocation: loadlocation, completion: { (results:[Weather]?) in
            
            if let weatherData = results {
                self.forecastDavar = weatherData
           
                    DispatchQueue.main.async {
                     self.summaryWeather.text = weatherData.first?.summary
                     self.imgWeather.image = UIImage(named: (weatherData.first?.icon)!)

                }
                
            }
        })
        WeatherCurrent.forecastHourly(withLocation: loadlocation, completion: { (results:[WeatherCurrent]?) in
            
            if let weatherData = results {
                self.forecastCurrent = weatherData
                
                DispatchQueue.main.async {
                    self.tempWeather.text = "\(weatherData.first!.temperature) °F"
                }
                
            }
        })
            print("================================================================")

        if(previousLoadLocation != nil)
        {
            print("2ndLat", previousLoadLocation!.latitude)
            print("2ndLong", previousLoadLocation!.longitude)
        }
        
        print("API Call", loadlocation.latitude)
        print("Oh Shit", loadlocation.longitude)

            print("================================================================")

        }
        print("loadlocationLat", loadlocation.latitude)
        print("loadlocationLong", loadlocation.longitude)
        
        previousLoadLocation?.latitude = loadlocation.latitude
        previousLoadLocation?.longitude = loadlocation.longitude
        previousLoadLocation = loadlocation
        
        previousLatitude = roundDouble(roundTwo: Double(loadlocation.latitude))
        previousLongitude = roundDouble(roundTwo: Double(loadlocation.longitude))

        
        
        print("================================================================")

    }
    
    func convertCoordinates(latitude: Double, longitude: Double)
    {
        let location1 = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location1) { (placemarks:[CLPlacemark]?, error:Error?) in
            if error == nil {
                if (placemarks?.first?.location) != nil {
                   let addressDictCity = placemarks!.first!.addressDictionary!["City"] as! String?
                    self.tempLocation = addressDictCity
                    self.currentLocation.text = "\(addressDictCity ?? "Fetching Data ...")"
                }
           }
        }
    }
    
    @IBAction func restAPIURL(_ sender: Any) {
        if let url = URL(string: "https://darksky.net/forecast/\(loadlocation.latitude),\(loadlocation.longitude)/us12/en") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }

    func roundDouble(roundTwo: Double) -> Double
    {
        let twoDecimals = Double(round(1000*roundTwo)/1000)
        return twoDecimals
        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sevenDay"
        {
            let navigation = segue.destination as! nextScreenNavigationController
            var nextScreenDelegate = WeatherTableViewController.init()
            nextScreenDelegate = navigation.viewControllers[0] as! WeatherTableViewController
            nextScreenDelegate.locValue = loadlocation
            nextScreenDelegate.locationNow = tempLocation
            locationManager.stopUpdatingLocation()
        }
        else if segue.identifier == "detailsDay"
        {
            let navigation = segue.destination as! detailsNavigationController
            var detailsVC = detailsViewController.init()
            detailsVC = navigation.viewControllers[0] as! detailsViewController
            
            let weatherData = forecastDavar
//            let detailsVC = segue.destination as! detailsViewController
            detailsVC.stringLocation = tempLocation ?? "Fetching Data ..."
            detailsVC.locValue = loadlocation
            detailsVC.minTemp = (weatherData.first?.temperatureMin) ?? 0
            detailsVC.maxTemp = (weatherData.first?.temperature) ?? 0
            detailsVC.cloudCover = weatherData.first?.cloudCover ?? 0.0
            detailsVC.humidity = weatherData.first?.humidity ?? 0.0
            detailsVC.dewPoint = weatherData.first?.dewPoint ?? 0.0
            detailsVC.windSpeed = (weatherData.first?.windSpeed) ?? 0
            locationManager.stopUpdatingLocation()
            
        }
        else if segue.identifier == "choose"
        {
            locationManager.stopUpdatingLocation()
        }
    
    }
}
