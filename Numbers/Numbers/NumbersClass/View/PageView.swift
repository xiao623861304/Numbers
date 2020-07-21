//
//  PageView.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class PageView: UIScrollView {
    
    var pageSize:CGSize = CGSize.zero
    var numImageArray:[UIImageView] = [UIImageView]()
    var labelArray:[UILabel] = [UILabel]()
    
    lazy var currentNumLable: UILabel = {
          let label = UILabel()
          label.font = UIFont.systemFont(ofSize: 17)
          label.textColor = UIColor.darkGray
          label.textAlignment = .center
          return label
    }()
        
    fileprivate lazy var totalNumLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        return label
    }()
        
    fileprivate lazy var lineLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.text = "\\"
        return label
    }()
    
    init(frame: CGRect, subViewsCount:Int) {
        super.init(frame: frame)
        self.isPagingEnabled = true
        self.backgroundColor = .white
        pageSize = frame.size
        setUpSubViewsUI(subViewsCount: subViewsCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpSubViewsUI(subViewsCount:Int){
        for _ in 0 ..< subViewsCount{
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: pageSize.width, height: pageSize.height))
            imageView.contentMode = .scaleAspectFit
            numImageArray.append(imageView)
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: imageView.bounds.width, height: 50))
            view.backgroundColor = UIColor.orange
            imageView.addSubview(view)
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: imageView.bounds.width, height: 50))
            label.font = UIFont.boldSystemFont(ofSize: 24)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            labelArray.append(label)
            view.addSubview(label)
             
            addSubviewForCurrent(view: imageView, current: false)
        }
        
        currentNumLable.frame = CGRect(x: pageSize.width - 130, y: pageSize.height*7/8, width: 50, height: 30)
        lineLable.frame = CGRect(x: pageSize.width - 80, y: currentNumLable.frame.minY, width: 10, height: 30)
        totalNumLable.frame = CGRect(x: pageSize.width - 70, y: currentNumLable.frame.minY, width: 50, height: 30)
        totalNumLable.text = "\(subViewsCount)"
        addSubview(currentNumLable)
        addSubview(lineLable)
        addSubview(totalNumLable)
    }
    
    func addSubviewForCurrent(view: UIView, current: Bool){
        var nPage = self.subviews.count
        view.frame = CGRect(x: CGFloat(nPage) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
        nPage += 1
        self.contentSize = CGSize(width: CGFloat(nPage) * pageSize.width, height: 0)
        super.addSubview(view)
    }
    
    func insertViewAboveSubview(_ view:UIView, subView: UIView) {
        view.insertSubview(currentNumLable, aboveSubview: subView)
            view.insertSubview(lineLable, aboveSubview: subView)
                view.insertSubview(totalNumLable, aboveSubview: subView)
    }
    
    func setCurrentPage(page: Int, animated: Bool){
        if(page >= self.subviews.count) {
            return;
        }
        
        let rect = CGRect(x: CGFloat(page) * pageSize.width, y: 0, width: pageSize.width, height: pageSize.height)
        
        self.scrollRectToVisible(rect, animated: animated)
        //kadk
    }
}
