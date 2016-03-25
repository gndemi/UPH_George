//
//  DashboardItem.swift
//  UPH-MyUnityPoint
//
//  Created by Aakash Sheth on 3/20/16.
//  Copyright © 2016 Aakash Sheth. All rights reserved.
//

import Foundation
import UIKit

class DashboardItem {

    // MARK: Properties
    var type : String
    var value: String
    var description: String
    var photo : UIImage?
    var label : String
    
    init?(type:String, value:String, description:String, photo:UIImage?, label: String)
    {
        // Init stored properties
        self.type = type
        self.value = value
        self.description = description
        self.photo = photo
        self.label = label
        
        if type.isEmpty || value.isEmpty || description.isEmpty {
            print("Error")
            return nil;
        }
    }
}