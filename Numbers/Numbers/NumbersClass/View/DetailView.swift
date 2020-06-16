//
//  DetailView.swift
//  Numbers
//
//  Created by yan feng on 2020/6/15.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class DetailView: UIView {
    lazy var numberLargeImage: UIImageView = {
        let numberImage = UIImageView()
        numberImage.contentMode = .scaleAspectFit
        return numberImage
    }()
    
    lazy var numberLabel: UILabel = {
        let numberLabel = UILabel()
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 30)
        return numberLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpSubViews(){
        //numberLargeImage
        numberLargeImage.frame = CGRect.zero
        addSubview(numberLargeImage)
        
        //numberLabel
        numberLabel.frame = CGRect.zero
        addSubview(numberLabel)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //numberLargeImage
        numberLargeImage.frame = frame
        
        //numberLabel
        numberLabel.frame = CGRect(x: 0, y: frame.size.height - 50, width: frame.size.width, height: 50)
    }
}
