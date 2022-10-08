//
//  PreviewViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 03/10/2022.
//

import UIKit
import WebKit
class PreviewViewController: UIViewController {
    // MARK: - Properties
    private let titleLBL : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Harry potter"
        return label
    }()
    private let overviewLBL: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.text = "This is the best movie over to watch as a kif!"
        return label
    }()
    private let downloadButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    private let webView : WKWebView = {
        let webView =  WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
        
    }
    

// MARK: - Helper functions
    func setupUI(){
        view.addSubview(webView)
        view.addSubview(titleLBL)
        view.addSubview(overviewLBL)
        view.addSubview(downloadButton)
        view.backgroundColor = .systemBackground
        applyConstaints()
    }
    func applyConstaints(){
        let webviewConstraint = [
            webView.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        let titleLBLConstraint = [
            titleLBL.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLBL.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let overviewLBLConstraint = [
            overviewLBL.topAnchor.constraint(equalTo: titleLBL.bottomAnchor, constant: 15),
            overviewLBL.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLBL.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let downloadButtonConstraint = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLBL.bottomAnchor, constant: 25),
            downloadButton.widthAnchor.constraint(equalToConstant: 140),
            downloadButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(webviewConstraint)
        NSLayoutConstraint.activate(titleLBLConstraint)
        NSLayoutConstraint.activate(overviewLBLConstraint)
        NSLayoutConstraint.activate(downloadButtonConstraint)
    }
    
    func configure(with model : PreviewViewModel) {
        titleLBL.text = model.title
        overviewLBL.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeView.id.videoId)") else { return}
        webView.load(URLRequest(url: url))
    }

}
