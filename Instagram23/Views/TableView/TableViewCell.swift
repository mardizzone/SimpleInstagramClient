//
//  TableViewCell.swift
//  
//
//  Created by Michael Ardizzone on 1/11/18.
//

import UIKit
import Alamofire

protocol ImageInfoDelegate {
    func likePhoto(at row: Int)
    func unlikePhoto(at row: Int)
}

class TableViewCell: UITableViewCell  {
    
    var delegate: ImageInfoDelegate?
    
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var instaImageView: UIImageView!
    var rowNumber : Int?
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
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        likeOrDislikePhoto()
    }
    
    private func likeOrDislikePhoto() {
        //we update the UI when the user taps the heart icon, but if the API request to instagram fails, we have to change the UI back
        if isLiked == false {
            updateUItoShowLikedImage()
            InstagramService.likePhoto(with: id, completionHandler: {success in
                if !success {
                    self.updateUItoShowUnLikedImage()
                }
            })
        } else {
            updateUItoShowUnLikedImage()
            InstagramService.dislikePhoto(with: id, completionHandler: { success in
                if !success {
                    self.updateUItoShowLikedImage()
                }
            })
        }
    }
    
    //set the image of the button based on it's liked state
    private func setupLikeButton() {
        if self.isLiked == true {
            likeButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
        } else {
            likeButton.setImage(#imageLiteral(resourceName: "whiteHeartLight"), for: .normal)
        }
    }
    
    private func updateUItoShowLikedImage() {
        if let rowIndex = self.rowNumber {
            self.delegate?.likePhoto(at: rowIndex)
        }
        self.likeButton.setImage(#imageLiteral(resourceName: "redHeart"), for: .normal)
        self.isLiked = true
    }
    
    private func updateUItoShowUnLikedImage() {
        if let rowIndex = self.rowNumber {
            self.delegate?.unlikePhoto(at: rowIndex)
        }
        self.likeButton.setImage(#imageLiteral(resourceName: "whiteHeartLight"), for: .normal)
        self.isLiked = false
    }
    
}

