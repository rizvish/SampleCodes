//
//  myTableViewCell.swift
//  swiftWeather
//
//  Created by Syed Hyder Rizvi on 7/4/17.
//  Copyright © 2017 Syed Hyder Rizvi. All rights reserved.
//

import UIKit

class myTableViewCell: UITableViewCell {
    @IBOutlet weak var myTextM: UILabel!

    @IBOutlet weak var myTextS: UILabel!
    
    @IBOutlet weak var myTextMinTemp: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    @IBOutlet weak var hourlyBttn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
