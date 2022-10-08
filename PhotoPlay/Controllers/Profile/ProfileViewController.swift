//
//  ProfileViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 06/10/2022.
//

import UIKit

class ProfileViewController: UIViewController {
// MARK: - Properties
    private var profileTitels = ["Account","Notification","Settings","Help","Logout"]
    private var titleImg = [UIImage(named: "user-2"),UIImage(named: "notifications-button"),UIImage(named: "Settings"),UIImage(named: "icon-2"),UIImage(named: "logout-2")]
    private let profileImg : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Profile-1")
      //  image.layer.borderColor = UIColor.systemYellow.cgColor
     //   image.layer.borderWidth = 3
        image.layer.cornerRadius = image.frame.width / 2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let namelable: UILabel = {
        let name = UILabel()
        name.text = "Ahmed Nagi"
        name.font = .systemFont(ofSize: 25, weight: .bold)
        name.textColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    private let profileTable : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isScrollEnabled = false
        table.register(UINib(nibName: ProfileTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(profileImg)
        view.addSubview(namelable)
        view.addSubview(profileTable)
        profileTable.delegate = self
        profileTable.dataSource = self
        applayConstraint()
        }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
      // profileTable.frame = view.bounds
    }
    
    func applayConstraint(){
        let profileImgConstrain = [
            profileImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            profileImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImg.widthAnchor.constraint(equalToConstant: 130),
            profileImg.heightAnchor.constraint(equalToConstant: 130)
        ]
        let namelableConstraint = [
            namelable.topAnchor.constraint(equalTo: profileImg.topAnchor, constant: 150),
            namelable.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]

        let profileTableConstraint = [
            profileTable.topAnchor.constraint(equalTo: namelable.topAnchor, constant: 70),
            profileTable.widthAnchor.constraint(equalTo: view.widthAnchor),
            profileTable.heightAnchor.constraint(equalTo: view.heightAnchor)
        ]
        NSLayoutConstraint.activate(profileImgConstrain)
        NSLayoutConstraint.activate(namelableConstraint)
       NSLayoutConstraint.activate(profileTableConstraint)
    }
   

 

}

extension ProfileViewController: table_datasource_delegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileTitels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.profileLBL.text = profileTitels[indexPath.row]
        cell.profileImg.image = titleImg[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
