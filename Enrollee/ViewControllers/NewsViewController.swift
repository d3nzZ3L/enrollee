//
//  NewsViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewsViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    let newsService = NewsService.shared
    var allNews = [News]()
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Новости"
        collectionView.register(R.nib.newsCollectionViewCell)
        SVProgressHUD.show()
        newsService.parseNews { (news, error) in
            guard error == nil, let news = news else {
                SVProgressHUD.showError(withStatus: error?.getDescription())
                return
            }
            self.allNews = news
            DispatchQueue.main.async {
                SVProgressHUD.dismiss(withDelay: 2.0)
                self.collectionView.reloadData()
            }
        }
    }
}
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allNews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let news = allNews[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newsCell, for: indexPath)!
        cell.configure(news: news)
        cell.contentView.layer.shadowRadius = 5
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        return cell
    }
}
extension NewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 320, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
