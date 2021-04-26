//
//  MapViewController.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit
import MapKit

class MapViewController : UIViewController {
    // MARK: - Properties
    
    private var backingRestaurants = [Restaurant]()
    
    var restaurants : [Restaurant] {
        get {
            return backingRestaurants
        } set {
            backingRestaurants = newValue
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Lifecycle
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var firstPoint : MKPointAnnotation? = nil
        
        for myRestaurant in backingRestaurants
        {
            let mapPoint = MKPointAnnotation()
            
            mapPoint.title = myRestaurant.name
            mapPoint.coordinate = CLLocationCoordinate2D(
                latitude: CLLocationDegrees(myRestaurant.location.lat),
                longitude: CLLocationDegrees(myRestaurant.location.lng))
            mapView.addAnnotation(mapPoint)
            
            if firstPoint == nil
            {
                firstPoint = mapPoint
            }
        }
        
        if let thePoint = firstPoint {
            
            let zoomRegion = mapView.regionThatFits(MKCoordinateRegion.init(center: thePoint.coordinate,
                                                                        span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.4),
                                                                                               longitudeDelta: CLLocationDegrees(0.4))))
            mapView.setRegion(zoomRegion, animated: false)
        }

    }
    
    
    // MARK: - IBActions
    
    @IBAction func done(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
