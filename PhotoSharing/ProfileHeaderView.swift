//
//  ProfileHeaderView.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import UIKit

class ProfileHeaderView: UIView {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var followButton: UIButton!
    @IBOutlet var contentView: UIView!

    static func fromNib() -> ProfileHeaderView
    {
        let headerView =  Bundle(for: ProfileHeaderView.self).loadNibNamed("ProfileHeaderView", owner: self, options: nil)?.first as! ProfileHeaderView

        headerView.nameLabel.font = Theme.lightWithSize(size: 24)
        headerView.descriptionLabel.font = Theme.regularWithSize(size: 13)

        headerView.nameLabel.textColor = Theme.titleBlack()
        headerView.descriptionLabel.textColor = Theme.descriptionBlack()

        headerView.followButton.backgroundColor = Theme.buttonBackgroundBlue()
        headerView.contentView.backgroundColor = Theme.backgroundGray()

        return headerView;
    }

    func bind(user : User)
    {
        nameLabel.attributedText = Theme.attributedString(text: user.name, font: Theme.lightWithSize(size: 24), textColor: Theme.titleBlack(), letterSpacing: 0.8)
        descriptionLabel.attributedText = Theme.attributedString(text: user.description, font: Theme.regularWithSize(size: 13), textColor: Theme.descriptionBlack(), letterSpacing: 0.6)
        profilePicture.image = user.profilePicture
    }

}
