//
//  RestaurantDetailViewController.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit
import MapKit

class RestaurantDetailViewController : UIViewController {
    // MARK: - Properties
    
    private var restaurant : Restaurant? = nil
    
    var detailRestaurant : Restaurant? {
        get {
            return restaurant
        } set {
            restaurant = newValue
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var restaurantName: UILabel!
    @IBOutlet var category: UILabel!
    @IBOutlet var address1: UILabel!
    @IBOutlet var address2: UILabel!
    @IBOutlet var address3: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var twitter: UILabel!
    @IBOutlet var facebook: UILabel!
    @IBOutlet var facebookName: UILabel!
    @IBOutlet var facebookUser: UILabel!
    @IBOutlet var toolbar: UIToolbar!
    
    // MARK: - Lifecycle
    
    override
    func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        toolbar.backgroundColor = .clear
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.setShadowImage(UIImage(), forToolbarPosition: .any)
        
        if let navController = self.navigationController {
            navController.setToolbarItems([UIBarButtonItem(systemItem: .done)], animated: false)
            navController.setNavigationBarHidden(false, animated: false)
        }
        
        if let myRestaurant = restaurant {
            setupTextDetails(myRestaurant: myRestaurant)
            setupMap(myRestaurant: myRestaurant)
        }
    }
    
    // MARK: - Private
    
    private func setupMap(myRestaurant : Restaurant) {
        // map
        let mapPoint = MKPointAnnotation()
        mapPoint.coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(myRestaurant.location.lat),
            longitude: CLLocationDegrees(myRestaurant.location.lng))
        let zoomRegion = mapView.regionThatFits(MKCoordinateRegion.init(center: mapPoint.coordinate,
                                                                        span: MKCoordinateSpan(latitudeDelta: CLLocationDegrees(0.1),
                                                                                               longitudeDelta: CLLocationDegrees(0.1))))
        mapView.addAnnotation(mapPoint)
        mapView.setRegion(zoomRegion, animated: false)
    }
    
    private func setupTextDetails(myRestaurant : Restaurant) {
        restaurantName.text = myRestaurant.name
        category.text = myRestaurant.category
        
        let addressLineCount = myRestaurant.location.formattedAddress.count
        if addressLineCount > 0 {
            address1.isHidden = false
            address1.text = myRestaurant.location.formattedAddress[0]
            
            if addressLineCount > 1 {
                address2.isHidden = false
                address2.text = myRestaurant.location.formattedAddress[1]
                
                if addressLineCount > 2 {
                    address3.isHidden = false
                    address3.text = myRestaurant.location.formattedAddress[2]
                }
                else {
                    address3.isHidden = true
                }
            }
            else {
                address2.isHidden = true
                address3.isHidden = true
            }
        }
        else {
            address1.isHidden = true
            address2.isHidden = true
            address3.isHidden = true
        }
        
        
        if let myContact = restaurant?.contact {
            phone.text = myContact.formattedPhone
            
            if myContact.twitter != nil {
                twitter.isHidden = false
                twitter.text = myContact.twitter
            }
            else {
                twitter.isHidden = true
            }
            
            if myContact.facebook != nil {
                facebook.isHidden = false
                facebook.text = myContact.facebook
            }
            else {
                facebook.isHidden = true
            }
            
            if myContact.facebookName != nil {
                facebookName.isHidden = false
                facebookName.text = myContact.facebookName
            }
            else {
                facebookName.isHidden = true
            }
            
            if myContact.facebookUsername != nil {
                facebookUser.isHidden = false
                facebookUser.text = myContact.facebookUsername
            }
            else {
                facebookUser.isHidden = true
            }
        }
        
    }
    
    // MARK: - IBActions
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
