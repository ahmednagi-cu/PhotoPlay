//
//  HomeCollectionViewCell.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit
import SDWebImage
class HomeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    static let identifier = "HomeCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    public func configure(with model : String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        posterImageView?.sd_setImage(with: url, completed: nil)
    }
 
}
