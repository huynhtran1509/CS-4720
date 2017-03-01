//
//  User.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import Foundation
import UIKit

public struct User
{
    var name : String
    var profilePicture : UIImage
    var description : String
    var statuses : [Status]
}
