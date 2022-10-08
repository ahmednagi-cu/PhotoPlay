//
//  UpcomingTableViewCell.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 02/10/2022.
//

import UIKit

class UpcomingTableViewCell: UITableViewCell {

    static let identifier = "UpcomingTableViewCell"
// MARK: - properties
    private let playTitleButton : UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(image, for: .normal)
        button.tintColor = .white
       
        return button
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let upcomingImageView : UIImageView = {
       let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(upcomingImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
        applyConstraints()
    }
    
    
// MARK: - Helper functions
    private func applyConstraints(){
        let upcomingImageViewConstrain = [
            upcomingImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            upcomingImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            upcomingImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            upcomingImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        let titleLabelConstrain = [
            titleLabel.leadingAnchor.constraint(equalTo: upcomingImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        let playTitleButtonConstraint = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(upcomingImageViewConstrain)
        NSLayoutConstraint.activate(titleLabelConstrain)
        NSLayoutConstraint.activate(playTitleButtonConstraint)
    }
    
    public func configure(with model: TitleViewModel){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        upcomingImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
