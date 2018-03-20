//
//  ChooseCityViewController.swift
//  swiftWeather
//
//  Created by Syed Hyder Rizvi on 7/6/17.
//  Copyright © 2017 Syed Hyder Rizvi. All rights reserved.
//

import UIKit
import GooglePlaces

class ChooseCityViewController: UIViewController {

    var coordinates: CLLocationCoordinate2D? = nil
    
    @IBOutlet weak var chooseCity: UIButton!

    @IBOutlet weak var placeLabel: UILabel!
    var tempLoc: String? = nil
    // Present the Autocomplete view controller when the button is pressed.
    
    @IBAction func autocompleteClicked(_ sender: UIButton) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    @IBAction func unwindToVC2(segue:UIStoryboardSegue) {
        
    }
    @IBAction func unwindSegueC(_ sender: Any) {
        performSegue(withIdentifier: "unwindC", sender: self)

    }
   
    @IBAction func addLocation(_ sender: Any) {
        let alert = UIAlertController(title: "Beta", message: "This feature is currently under construction", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "present" {
            
            if (placeLabel.text?.isEmpty)! {
                
                let alert = UIAlertController(title: "No Location Provided", message: "Please choose a location", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return false
            }
                
            else
            {
                return true
            }
        }
        
        // by default, transition
        return true

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "present"
        {
            
            let cityVC = segue.destination as! WeatherTableViewController
            cityVC.locValue = coordinates
            cityVC.locationNow = tempLoc
        }
    }

}


extension ChooseCityViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        placeLabel.text = place.formattedAddress
        tempLoc = place.formattedAddress
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(place.formattedAddress!) { (placemarks, error) in
            guard
                let placemarks = placemarks,
                let location = placemarks.first?.location
                else {
                    // handle no location found
                    return
            }
            self.coordinates = CLLocationCoordinate2D( latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
