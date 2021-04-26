//
//  Restaurant.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation

struct Restaurants : Decodable {
    let restaurants : [Restaurant]
}

struct Restaurant : Decodable {
    
    let name : String
    
    let backgroundImageURL : String
    
    let category : String

    let contact : Contact?

    let location : Location

}
