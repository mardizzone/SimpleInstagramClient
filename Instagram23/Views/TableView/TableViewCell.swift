//
//  TableViewCell.swift
//  
//
//  Created by Michael Ardizzone on 1/11/18.
//

import UIKit
import Alamofire


class TableViewCell: UITableViewCell {
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var instaImageView: UIImageView!
    var id : String?
    var isLiked : Bool? {
        didSet {
            setupLikeButton()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeOrDislikePhoto()
    }

    
    private func likeOrDislikePhoto() {
        if isLiked == false {
            likeButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
            isLiked = true
            InstagramService.likePhoto(with: id)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "whiteHeartLight"), for: .normal)
            isLiked = false
            InstagramService.dislikePhoto(with: id)
        }
    }
    
    private func setupLikeButton() {
        if self.isLiked == true {
            likeButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "whiteHeartLight"), for: .normal)
        }
    }
    
    
}

