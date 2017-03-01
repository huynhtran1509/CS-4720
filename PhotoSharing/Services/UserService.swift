//
//  UserService.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import Foundation
import UIKit

public class UserService
{

    static private var privateUser : User?

    static func currentUser() -> User
    {
        if let privateUser = privateUser
        {
            return privateUser;
        }

        var statuses =  [Status]()

        statuses.append(Status(datePosted: "10 min", description: "Chilling in China Town", image: UIImage(named:"ChinaTown")!, locationName: "Chinatown, San Francisco", commentCount: 941, likeCount: 10152))
        statuses.append(Status(datePosted: "3 days", description: "Hellllooooo Coloooraaaddoooo", image: UIImage(named:"Colorado")!, locationName: nil, commentCount: 264, likeCount: 2346))
        statuses.append(Status(datePosted: "10 days", description: "Utah at night is breathtaking.", image: UIImage(named:"Utah")!, locationName: nil, commentCount: 693, likeCount: 12346))

        let user = User(name: "Jennifer C.", profilePicture: UIImage(named: "profile")!, description: "Travel blogger, cook & all around amazing person", statuses: statuses)
        privateUser = user;

        return user;
    }
}
