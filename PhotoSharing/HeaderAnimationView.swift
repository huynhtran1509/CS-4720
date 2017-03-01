//
//  AnimatedHeaderView.swift
//  PhotoSharing
//
//  Created by Chris Mays on 3/1/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import Foundation
import UIKit

class HeaderAnimationView : UIView
{

    let profileImage : UIImageView
    let nameLabel = UILabel()

    let initialY = CGFloat(171.0);

    let initialWidth = CGFloat(120.0);
    let initialHeight = CGFloat(120.0);

    private var topConstraint : NSLayoutConstraint!
    private var centerXConstraint : NSLayoutConstraint!
    private var widthConstraint : NSLayoutConstraint!
    private var heightConstraint : NSLayoutConstraint!

    weak var passTouchesToView : UIView?

    override init(frame: CGRect) {
        profileImage = UIImageView(image: UIImage(named: "profile"))

        super.init(frame: frame)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = Theme.regularWithSize(size: 14)
        nameLabel.text = "Jennifer C."

        addSubview(profileImage)
        addSubview(nameLabel)

        profileImage.translatesAutoresizingMaskIntoConstraints = false

        topConstraint = profileImage.centerYAnchor.constraint(equalTo: topAnchor, constant: initialY)
        centerXConstraint = profileImage.centerXAnchor.constraint(equalTo: centerXAnchor)

        widthConstraint = profileImage.widthAnchor.constraint(equalToConstant: initialWidth)

        heightConstraint = profileImage.heightAnchor.constraint(equalToConstant: initialHeight)


        nameLabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 14).isActive = true
        nameLabel.textColor = UIColor.white

        topConstraint.isActive = true
        widthConstraint.isActive = true
        centerXConstraint.isActive = true
        heightConstraint.isActive = true

    }

    func setState(percentage : CGFloat)
    {
        let endYKeyframe1 = CGFloat(71.5)

        let endKeyFrame2Width = CGFloat(30.0)
        let endKeyFrame2Height = CGFloat(30.0)
        let endKeyFrame2CenterX = CGFloat(45.0)
        let endKeyFrame2CenterXOffset = -((frame.size.width/2) - CGFloat(endKeyFrame2CenterX))
        let endKeyFrame2Y = CGFloat(40)

        let endKeyFrame1Percentage = CGFloat(0.29)
        let endKeyFrame2Percentage = CGFloat(0.54)
        let endKeyFrame3Percentage = CGFloat(0.6)


        if (percentage > endKeyFrame1Percentage && percentage <= endKeyFrame2Percentage)
        {

            let keyFramePercentage = CGFloat((percentage - endKeyFrame1Percentage)/(endKeyFrame2Percentage - endKeyFrame1Percentage))

            let goalWidth = endKeyFrame2Width
            let goalHeight = endKeyFrame2Height
            let goalY = endKeyFrame2Y
            let goalX = CGFloat(45.0)

            let diffHeight = (initialHeight - goalHeight) * keyFramePercentage
            let diffWidth = (initialWidth - goalWidth) * keyFramePercentage

            let diffCenterY = (endYKeyframe1 - goalY) * CGFloat(keyFramePercentage)

            let diffX = ((frame.width/2) - goalX) * keyFramePercentage

            let newWidth = initialWidth - diffWidth
            let newHeight = initialHeight - diffHeight
            let newCenterY = endYKeyframe1 - diffCenterY
            let newCenterX =  -diffX

            nameLabel.alpha = 0
            widthConstraint.constant = max(newWidth, 10)
            heightConstraint.constant = max(newHeight, 10)
            topConstraint.constant = newCenterY
            centerXConstraint.constant = newCenterX
        }
        else if (percentage <= endKeyFrame2Percentage)
        {
            let pixelDifference = self.frame.size.height * CGFloat(percentage)
            heightConstraint.constant = initialHeight
            widthConstraint.constant = initialWidth
            centerXConstraint.constant = 0
            topConstraint.constant = initialY - pixelDifference
            nameLabel.alpha = 0
        }
        else
        {
            let keyFramePercentage = CGFloat((percentage - endKeyFrame2Percentage)/(endKeyFrame3Percentage - endKeyFrame2Percentage))

            nameLabel.alpha = keyFramePercentage
            widthConstraint.constant = endKeyFrame2Width
            heightConstraint.constant = endKeyFrame2Height
            topConstraint.constant = endKeyFrame2Y
            centerXConstraint.constant = endKeyFrame2CenterXOffset
        }
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if let hitTestView = passTouchesToView
        {
            return hitTestView.hitTest(convert(point, to: hitTestView), with: event)
        }

        return nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
