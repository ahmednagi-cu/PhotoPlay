//
//  CollectionViewTableViewCell.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 29/09/2022.
//

import UIKit
import CoreData
protocol CollectionViewTableViewCellDelegate : AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell :CollectionViewTableViewCell, viewModel: PreviewViewModel)
}
class CollectionViewTableViewCell: UITableViewCell {

static let identifier = "CollectionViewTableViewCell"
    weak var delegate : CollectionViewTableViewCellDelegate?
    private var titles : [Title] = [Title]()
// MARK: - Properties
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: HomeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        return collectionView
    }()
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = contentView.bounds
    }
    
// MARK: - Helper Functions
    public func configure(with  titles: [Title]){
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexpath: IndexPath){
        DataPersisten.shared.downloadwith(model: titles[indexpath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("downloaded"), object: nil)
                print("download to Database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}

extension CollectionViewTableViewCell : colletion_datasource_delegate_layout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else
        { return UICollectionViewCell() }
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
           
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return}
        
        APICaller.shared.getMovie(with: titleName + " trailer") {[weak self] result  in
            switch result {
            case .success(let videoElement):
                print(videoElement.id)
                let title = self?.titles[indexPath.row]
                guard let titleOverview = title?.overview else { return}
                guard let strongSelf = self else { return}
                let viewModel = PreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: titleOverview)
                strongSelf.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self]_ in
            let downloadAction = UIAction(title: "Download", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                self?.downloadTitleAt(indexpath: indexPath)
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [downloadAction])
        }
        return config
    }
    
    
}
