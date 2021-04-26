//
//  Location.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation

struct Location : Decodable {
    
    let address : String
    
    let crossStreet : String?
    
    let lat : Float
    
    let lng : Float
    
    let postalCode : String?
    
    let cc : String
    
    let city : String
    
    let state : String
    
    let country : String
    
    let formattedAddress : [String]
    

    
}
