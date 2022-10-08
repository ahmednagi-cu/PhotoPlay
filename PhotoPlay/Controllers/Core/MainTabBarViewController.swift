//
//  ViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupControllers()
    }

    public func setupControllers(){
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: UpcomingViewController())
        let vc3 = UINavigationController(rootViewController: SearchViewController())
        let vc4 = UINavigationController(rootViewController: DownloadViewController())
       
        vc1.tabBarItem.image = UIImage(named: "Home")
        vc2.tabBarItem.image = UIImage(systemName: "play.circle")
        vc3.tabBarItem.image = UIImage(named: "search")
        vc4.tabBarItem.image = UIImage(named: "download")
        
    
        tabBar.tintColor = .label
        vc1.title = "Home"
        vc2.title = "Upcoming"
        vc3.title = "Search"
        vc4.title = "Download"
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
}

