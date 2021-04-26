//
//  RestaurantCell.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit

class RestaurantCell : UICollectionViewCell {
    // MARK: - Properties
    private var backingRow = -1
    var row : Int {
        get {
            return backingRow
        } set {
            backingRow = newValue
        }
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var category: UILabel!
    
    
    
}
