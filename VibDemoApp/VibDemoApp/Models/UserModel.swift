//
//  UserModel.swift
//  VibDemoApp
//
//  Created by MYGENOMEBOX INDIA on 30/07/21.
//

import Foundation
import UIKit

class UserModel:NSObject{
    
   var username : String?
   var userImage : UIImage?
   var userLoacation: String?
    
     init(username: String,userImage:UIImage,userLoacation:String) {
        self.username = username
        self.userImage = userImage
        self.userLoacation = userLoacation
    }
}
