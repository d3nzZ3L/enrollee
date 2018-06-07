//
//  NewsCollectionViewCell.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorners(radius: 10)
    }
    
    func configure(news: News) {
        titleLabel.text = news.title
        descriptionLabel.text = news.desc
    }

}
