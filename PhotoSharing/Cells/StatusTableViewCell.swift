//
//  StatusTableViewCell.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var statusDateLabel: UILabel!
    @IBOutlet var statusDescriptionLabel: UILabel!
    @IBOutlet var statusImage: UIImageView!
    @IBOutlet var statusCommentsLabel: UILabel!
    @IBOutlet var statusLikesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.selectionStyle = .none
    }

    public func bindStatus(status : Status, user : User)
    {
        profileImage.image = user.profilePicture
        profileNameLabel.text = user.name
        statusDateLabel.text = status.datePosted
        statusDescriptionLabel.text = status.description
        statusImage.image = status.image
        statusCommentsLabel.text = "\(status.commentCount) comments"
        statusLikesLabel.text = "\(status.likeCount) likes"

        profileNameLabel.font = Theme.semiBoldWithSize(size: 14)
        profileNameLabel.textColor = Theme.socialBlue()

        statusDateLabel.font = Theme.regularWithSize(size: 12)
        statusDateLabel.textColor = Theme.titleBlack()

        statusDescriptionLabel.attributedText = Theme.attributedString(text: status.description, font: Theme.lightWithSize(size: 18), textColor: Theme.titleBlack(), letterSpacing: 0.6)

        statusLikesLabel.font = Theme.semiBoldWithSize(size: 14)
        statusCommentsLabel.font = Theme.semiBoldWithSize(size: 14)

        statusLikesLabel.textColor = Theme.socialBlue()
        statusCommentsLabel.textColor = Theme.socialBlue()

    }
    
}
