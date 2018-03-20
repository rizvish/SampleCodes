//
//  poweredByViewController.swift
//  swiftWeather
//
//  Created by Syed Hyder Rizvi on 7/7/17.
//  Copyright © 2017 Syed Hyder Rizvi. All rights reserved.
//

import UIKit

class poweredByViewController: UIViewController {

    @IBOutlet weak var google: UIImageView!
    @IBOutlet weak var darkSky: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func unwindToVC1(_ sender: Any) {
         performSegue(withIdentifier: "unwindToVC1", sender: self)
    }

    @IBAction func unwindToVC2P(_ sender: Any) {
         performSegue(withIdentifier: "unwindToVC2", sender: self)
    }

    @IBAction func darkSkyLink(_ sender: Any) {
        
        if let url = URL(string: "https://darksky.net/poweredby/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func googleLink(_ sender: Any) {
        if let url = URL(string: "https://developers.google.com/places/ios-api/start") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    @IBAction func logomakrLink(_ sender: Any) {
        if let url = URL(string: "https://logomakr.com/") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
