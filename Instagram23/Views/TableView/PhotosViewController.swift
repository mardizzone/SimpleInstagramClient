//
//  PhotosViewController.swift
//  Instagram23
//
//  Created by Michael Ardizzone on 1/13/18.
//  Copyright © 2018 Michael Ardizzone. All rights reserved.
//

import UIKit
import Nuke
import WebKit
import Pastel

class PhotosViewController: UIViewController {
    
    var postData = [ImageInfo]()

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBackGround()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        KeychainHelper.shared.revokeAccessToken()
        WebCacheCleaner.clean()
        InstagramRouter.presentLoginScreen(view: self)
    }
    
    func setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 640
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        Networking.requestRecentDataFromInstagram(completionHandler: { results in
            self.postData.append(contentsOf: results.data)
            self.tableView.reloadData()
        })
    }
    
    func setupBackGround() {
        let pastelView = PastelView(frame: view.bounds)
        // Custom Direction
        pastelView.startPastelPoint = .bottomLeft
        pastelView.endPastelPoint = .topRight
        // Custom Duration
        self.hideKeyboardWhenTappedAround()
        pastelView.animationDuration = 3.0
        // Custom Color
        pastelView.setColors([UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                              UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                              UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                              UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                              UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)])
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }

}

extension PhotosViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        configure(cell, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    private func configure(_ cell: TableViewCell, atIndexPath indexPath: IndexPath) {
        let imageURL = postData[indexPath.row].images.standard_resolution.url
        let url = URL(string: imageURL)!

        cell.id = postData[indexPath.row].id
        cell.isLiked = postData[indexPath.row].user_has_liked
        var request = Request(url: url)
//        request.progress = { completed, total in
//            self.tableView.reloadRows(at: [indexPath], with: .fade)
//        }
        Manager.shared.loadImage(with: request, into: cell.instaImageView)
    }
}

// MARK: - Search Function
extension PhotosViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        print("not implemented, seach API endpoint not enabled in Sandbox mode")
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =     UITapGestureRecognizer(target: self, action:    #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
