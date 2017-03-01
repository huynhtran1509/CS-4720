//
//  ProfileCollectionTableViewCell.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import UIKit

class ProfileCollectionTableViewCell: UITableViewCell {

    @IBOutlet var photosTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        photosTitleLabel.font = Theme.semiBoldWithSize(size: 14)
        photosTitleLabel.textColor = Theme.titleBlack()
        self.selectionStyle = .none
    }

}
