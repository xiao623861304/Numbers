//
//  MianListTableViewCell.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class MainListTableViewCell: UITableViewCell {
    lazy var numberImage : UIImageView = {
        let numberImage = UIImageView()
        numberImage.contentMode = .scaleAspectFit
        numberImage.translatesAutoresizingMaskIntoConstraints = false
        return numberImage
    }()
    lazy var numberLabel : UILabel = {
        let numberLabel = UILabel()
        numberLabel.translatesAutoresizingMaskIntoConstraints = false
        return numberLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(numberImage)
        addSubview(numberLabel)
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews(){
        //numberImage
        NSLayoutConstraint(item: numberImage, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 20).isActive = true
        NSLayoutConstraint(item: numberImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: numberImage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 60).isActive = true
        NSLayoutConstraint(item: numberImage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100).isActive = true
        //numberLabel
        NSLayoutConstraint(item: numberLabel, attribute: .left, relatedBy: .equal, toItem: numberImage, attribute: .right, multiplier: 1, constant: 25).isActive = true
        NSLayoutConstraint(item: numberLabel, attribute: .centerY, relatedBy: .equal, toItem: numberImage, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: numberLabel, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -10).isActive = true
        NSLayoutConstraint(item: numberLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.backgroundColor = .gray
        } else {
            contentView.backgroundColor = .clear
        }

    }
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = UIColor.orange
        } else {
            contentView.backgroundColor = .clear
        }
    }

}
