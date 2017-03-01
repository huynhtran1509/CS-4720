//: Playground - noun: a place where people can play

import UIKit
import XCPlayground
import PlaygroundSupport
import AVFoundation

//At first I had the top position
//But realized quickly I needed middle
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

    override init(frame: CGRect) {
        profileImage = UIImageView(image: UIImage(named: "profile"))
        super.init(frame: frame)

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 12)
        nameLabel.text = "Jennifer C."
        profileImage.alpha = 0.5
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

    func setState(percentage : Double)
    {

        let endYKeyframe1 = CGFloat(71.5)


        let endKeyFrame2Width = CGFloat(28.0)
        let endKeyFrame2Height = CGFloat(28.0)
        let endKeyFrame2CenterX = CGFloat(45.0)
        let endKeyFrame2CenterXOffset = -((frame.size.width/2) - CGFloat(endKeyFrame2CenterX))
        let endKeyFrame2Y = CGFloat(37)

        if (percentage >= 0.29 && percentage <= 0.71)
        {

            let keyFramePercentage = CGFloat((percentage - 0.29)/(1.0 - 0.29 - 0.29))

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

            widthConstraint.constant = max(newWidth, 10)
            heightConstraint.constant = max(newHeight, 10)
            topConstraint.constant = newCenterY
            centerXConstraint.constant = newCenterX
        }
        else if (percentage < 0.29)
        {
            let pixelDifference = self.frame.size.height * CGFloat(percentage)
            heightConstraint.constant = initialHeight
            widthConstraint.constant = initialWidth
            centerXConstraint.constant = 0
            topConstraint.constant = initialY - pixelDifference
        }
        else
        {
            let keyFramePercentage = CGFloat((percentage - 0.71)/(1.0 - 0.71))

            nameLabel.alpha = keyFramePercentage
            widthConstraint.constant = endKeyFrame2Width
            heightConstraint.constant = endKeyFrame2Height
            topConstraint.constant = endKeyFrame2Y
            centerXConstraint.constant = endKeyFrame2CenterXOffset
        }
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Responder
{
    var headerView : HeaderAnimationView
    var playerView : AVPlayer;

    let minTime = 100
    let maxTime = 200
    let initialTime = 2.0
    init(_ _headerView : HeaderAnimationView, playerView _playerView : AVPlayer)
    {
        headerView = _headerView
        playerView = _playerView
        playerView.seek(to: CMTime.init(seconds: initialTime, preferredTimescale: 90000))
    }

    @objc func valueChanged(slider : UISlider)
    {
        playerView.seek(to: CMTime.init(seconds: (2.0 * Double(slider.value) + initialTime), preferredTimescale: 90000), toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        headerView.setState(percentage: Double(slider.value))
        playerView.pause()
    }
}


var animationView = HeaderAnimationView(frame: CGRect(x: 0, y: 0, width: 375, height: 344))
animationView.backgroundColor = UIColor.white

var player = AVPlayer(url: Bundle.main.url(forResource: "uva", withExtension: "mov")!)
var playerLayer = AVPlayerLayer(player: player)
playerLayer.position = animationView.center
playerLayer.frame = CGRect(x: 0, y: 0, width: 375, height: 375 * 1.7786458333)

animationView.layer.insertSublayer(playerLayer, at: 0)

var slider = UISlider()
animationView.addSubview(slider)
slider.translatesAutoresizingMaskIntoConstraints = false
slider.widthAnchor.constraint(equalToConstant: 200).isActive = true
slider.bottomAnchor.constraint(equalTo: animationView.bottomAnchor).isActive = true
slider.centerXAnchor.constraint(equalTo: animationView.centerXAnchor).isActive = true


var sliderResponder = Responder(animationView, playerView: player)

slider.addTarget(sliderResponder, action: #selector(Responder.valueChanged), for: .valueChanged)
slider.value = 1

sliderResponder.valueChanged(slider: slider)

PlaygroundPage.current.liveView = animationView

