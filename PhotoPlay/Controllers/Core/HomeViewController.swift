//
//  HomeViewController.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit
enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}
class HomeViewController: UIViewController {
// MARK: - Properties
    
    private var randomTrendingMovies : Title?
    private var headerView : HeroHeaderUIView?
    
    let sectionTitels : [String] = ["Trending movies","Trending Tv","Popular","Upcoming Movies","Top rated"]
    private let homeFeedTable : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UINib(nibName: CollectionViewTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureHeroHeaderView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
        //self.navigationController?.isNavigationBarHidden = true
        
    }

// MARK: - Helper functions
    func setupUI(){
        view.backgroundColor = .systemBackground
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        configureNavbar()
        view.addSubview(homeFeedTable)
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 550))
        homeFeedTable.tableHeaderView = headerView

    }
    private func configureNavbar(){
        var image = UIImage(named: "Profile")
        image = image?.withRenderingMode(.alwaysOriginal)
        image?.withTintColor(.yellow)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(goToProfile))
        navigationController?.navigationBar.tintColor = .yellow
        
    }
    
    func configureHeroHeaderView(){
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovies = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "" , posterURL: selectedTitle?.poster_path ?? "" ))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
// MARK: - @Objc
    @objc func goToProfile(){
        let vc = ProfileViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    
}

 
extension HomeViewController: table_datasource_delegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue :
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles) :
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue :
            APICaller.shared.getTrendingTv { result in
                switch result {
                case .success(let titles) :
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue :
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let titles) :
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue :
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles) :
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue :
            APICaller.shared.getTopratedMovies { result in
                switch result {
                case .success(let titles) :
                    cell.configure(with: titles)
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        default :
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 22, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100 , height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizerFirstLetter()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitels[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}


extension HomeViewController : CollectionViewTableViewCellDelegate {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: PreviewViewModel) {
        DispatchQueue.main.async {
            let vc = PreviewViewController()
            vc.configure(with: viewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
           
    }
    
    
}
