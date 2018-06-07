//
//  AddItemTableViewCell.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 20.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit

class AddItemTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        valueLabel.isHidden = true
    }

    func configure(title: String, value: String?) {
        if let value = value {
            valueLabel.isHidden = false
            valueLabel.text = value
        }
        titleLabel.text = title
    }
}
