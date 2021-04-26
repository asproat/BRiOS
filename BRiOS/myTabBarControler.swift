//
//  myTabViewControler.swift
//  BRiOS
//
//  Created by BR Test on 4/24/21.
//

import Foundation
import UIKit

class myTabBarController : UITabBarController {
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        var supportedOrientations = UIInterfaceOrientationMask.all
    
        if UIDevice.current.userInterfaceIdiom  == .phone {
            supportedOrientations = UIInterfaceOrientationMask.portrait
            
        }
        
        return supportedOrientations

    }
    override open var shouldAutorotate: Bool { return UIDevice.current.userInterfaceIdiom  == .pad }
}
