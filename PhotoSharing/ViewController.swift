//
//  ViewController.swift
//  PhotoSharing
//
//  Created by Chris Mays on 2/20/17.
//  Copyright © 2017 WillowTree. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var photosTable: UITableView!

    let animatedHeader = HeaderAnimationView(frame: CGRect.zero)

    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.addSubview(animatedHeader)

        animatedHeader.translatesAutoresizingMaskIntoConstraints = false;
        animatedHeader.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        animatedHeader.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        animatedHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        animatedHeader.heightAnchor.constraint(equalToConstant: 344).isActive = true;

        animatedHeader.setState(percentage: 0.0)
        animatedHeader.passTouchesToView = photosTable

        photosTable.rowHeight = UITableViewAutomaticDimension

        photosTable.delegate = self
        photosTable.dataSource = self
        photosTable.separatorStyle = .none
        photosTable.showsVerticalScrollIndicator = false;

        let tableHeader = ProfileHeaderView.fromNib()
        tableHeader.frame = CGRect(x: 0, y: 0, width: 300, height: 340 - navigationController!.navigationBar.frame.size.height)
        tableHeader.backgroundColor = UIColor.clear
        tableHeader.bind(user: UserService.currentUser())
        photosTable.tableHeaderView = tableHeader

        let cellNib = UINib(nibName: "ProfileCollectionTableViewCell", bundle: Bundle(for: ProfileCollectionTableViewCell.self))
        photosTable.register(cellNib, forCellReuseIdentifier: "ProfileCollectionTableViewCell")

        let statusNib = UINib(nibName: "StatusTableViewCell", bundle: Bundle(for: StatusTableViewCell.self))
        photosTable.register(statusNib, forCellReuseIdentifier: "StatusTableViewCell")
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()

        navigationController?.setViewControllers([UIViewController(), self], animated: false)

        self.view.backgroundColor = Theme.backgroundGray()
        self.setupBackButton()
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource
{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return UserService.currentUser().statuses.count + 1;
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (indexPath.row == 0)
        {
            return tableView.dequeueReusableCell(withIdentifier: "ProfileCollectionTableViewCell")!
        }

        let statusIndex = indexPath.row - 1

        let statusCell = tableView.dequeueReusableCell(withIdentifier: "StatusTableViewCell") as! StatusTableViewCell

        statusCell.bindStatus(status: UserService.currentUser().statuses[statusIndex], user: UserService.currentUser())

        return statusCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0)
        {
            return 425
        }

        return UITableViewAutomaticDimension;
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400;
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        animatedHeader.setState(percentage: scrollView.contentOffset.y/340)
    }
}

extension ViewController
{
    func setupBackButton()
    {
        let imageView = UIImageView(image: UIImage(named: "arrowLeft"))
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true;
        imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 33).isActive = true;

    }
}
