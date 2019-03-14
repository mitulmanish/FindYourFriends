//
//  CustomTableViewCell.swift
//  DistanceCalculator
//
//  Created by Mitul Manish on 14/3/19.
//  Copyright © 2019 Mitul Manish. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textLabel?.textColor = .white
        contentView.backgroundColor = .gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
