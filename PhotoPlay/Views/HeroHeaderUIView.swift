//
//  HeroHeaderUIView.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit

class HeroHeaderUIView: UIView {
// MARK: - Properties
    private let label :UILabel = {
        let label = UILabel()
        label.text = "4.0"
        label.font = .systemFont(ofSize: 35, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let heroImage : UIImageView = {
        let heroimage = UIImageView()
        heroimage.image = UIImage(named: "HeroImage")
        heroimage.contentMode  = .scaleAspectFill
        heroimage.clipsToBounds = true
        return heroimage
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImage)
        addGradient()
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImage.frame = bounds
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK : - Helper functions
    
    private func addGradient(){
        let gradientlayer = CAGradientLayer()
        gradientlayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientlayer.frame = bounds
        layer.addSublayer(gradientlayer)
    }
  
    
    public func configure(with model : TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        heroImage.sd_setImage(with: url, completed: nil)
    }
}
