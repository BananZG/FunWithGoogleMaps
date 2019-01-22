//
//  MapViewController.swift
//  FunWithGoogleMaps
//
//  Created by Gan Jun Jie on 22/01/2019.
//  Copyright © 2019 Gan Jun Jie. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    override func loadView() {
        
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 1.2962833, longitude: 103.787403, zoom: 14.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 1.2962833, longitude: 103.787403)
        marker.title = "99.co"
        marker.snippet = "Hey dont touch me!"
        marker.map = mapView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

