//
//  MainViewController.swift
//  FunWithGoogleMaps
//
//  Created by Gan Jun Jie on 22/01/2019.
//  Copyright © 2019 Gan Jun Jie. All rights reserved.
//

import UIKit
import GoogleMaps

class MainViewController: UIViewController {

    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.mainTextView.text = GMSServices.openSourceLicenseInfo()
    }


}

