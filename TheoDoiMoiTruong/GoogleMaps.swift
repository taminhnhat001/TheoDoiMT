//
//  GoogleMaps.swift
//  TheoDoiMoiTruong
//
//  Created by Duc on 5/4/20.
//  Copyright © 2020 Duc. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class GoogleMaps: UIViewController {
    var mapView:GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 20.976106, longitude: 105.815626, zoom: 10)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let currentLocation = CLLocationCoordinate2DMake(20.976096, 105.815593)
        let marker = GMSMarker(position: currentLocation)
        marker.title = "Thang Long University"
        marker.map = mapView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextL))
    
    }
    
    @objc func nextL() {
        let nextLocation = CLLocationCoordinate2DMake(21.001763, 105.815960)
        mapView?.camera = GMSCameraPosition.camera(withLatitude: nextLocation.latitude, longitude: nextLocation.longitude, zoom: 15)
        let marker = GMSMarker(position: nextLocation)
        marker.title = "Royal City"
        marker.map = mapView
    }

}
