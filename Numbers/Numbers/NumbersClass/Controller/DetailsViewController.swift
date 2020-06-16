//
//  DetailsViewController.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {

    var detailView:DetailView!
    var pageView: PageView!
    lazy var pageController = UIPageControl()

    fileprivate lazy var detailViewModel : DetailsViewModel = DetailsViewModel()
    lazy var numberViewModel : MainListViewModel = MainListViewModel()
    
    fileprivate var startOffsetX : CGFloat = 0
    var currentNameOfNumber = ""
    var currentIndexOfImage : Int = 0
    var imageGroupCount:Int = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            setUpUI()
        } else {
            setUpUIForPad()
        }
        loadingData(currentPage: currentIndexOfImage)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            if Platform.isSimulator {
               detailView.frame.size = CGSize(width: (size.width+view.frame.origin.x)/2, height: size.height)
            } else {
                detailView.frame.size = CGSize(width: size.width, height: size.height)
            }
        } 
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Set up subviews UI of DetailsViewController
extension DetailsViewController {
    
     func setUpUI(){
         var frame = view.frame
         pageView = PageView(frame: frame, subViewsCount: imageGroupCount)
         pageView.delegate = self
         view.addSubview(pageView)
             
         frame.origin.y += frame.size.height*7/8
         frame.size.height = frame.size.height/8
         frame.size.width = view.frame.size.width
         pageController.frame = frame
         pageController.pageIndicatorTintColor = .orange
         pageController.currentPageIndicatorTintColor = .darkGray
         pageController.numberOfPages = 10
         view.insertSubview(pageController, aboveSubview: pageView)
         pageController.isUserInteractionEnabled = false
         
        pageView.insertViewAboveSubview(view, subView: pageController)
     }
         
     func setUpUIForPad(){
         var frame = view.frame
         frame.size.width = frame.size.width/2
         detailView = DetailView(frame: frame)
         view.addSubview(detailView)
     }
}

// MARK: Loading data function
extension DetailsViewController {
     
     func loadingData(currentPage : Int){
         
         let urlString = "http://dev.tapptic.com/test/json.php?name=\(currentNameOfNumber)"
        self.view.isUserInteractionEnabled = false
         detailViewModel.loadDetailData(type: .get, urlString: urlString) {
             DispatchQueue.main.async {
                if (UIDevice.current.userInterfaceIdiom == .phone) {
                    self.pageView.numImageArray[currentPage].YF_WebImage(url: self.detailViewModel.details.image, defaultImage: "placeholder")
                    self.pageView.labelArray[currentPage].text = self.detailViewModel.details.text
                    self.setCurrentIndex(currentPage)
                } else {
                    self.detailView.numberLargeImage.YF_WebImage(url: self.detailViewModel.details.image, defaultImage: "placeholder")
                    self.detailView.numberLabel.text = self.detailViewModel.details.text
                }
                self.view.isUserInteractionEnabled = true
             }
         }
     }
    
     func loadTatgetPage(tatgetPage : Int) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         if !appDelegate.disconnect {
            self.view.isUserInteractionEnabled = false
         }
         let urlString = "http://dev.tapptic.com/test/json.php?name=\(self.numberViewModel.NumbersGroups[tatgetPage].name)"
         detailViewModel.loadDetailData(type: .get, urlString: urlString) {
             DispatchQueue.main.async {
                self.pageView.numImageArray[tatgetPage].YF_WebImage(url: self.detailViewModel.details.image, defaultImage: "placeholder")
                self.pageView.labelArray[tatgetPage].text = self.detailViewModel.details.text
                self.view.isUserInteractionEnabled = true
             }
              
         }
     }
}

// MARK: Private function
extension DetailsViewController {
    
    func setCurrentIndex(_ currentIndex : Int) {
        var rect = view.frame
        rect.origin.x = CGFloat(currentIndex) * rect.size.width
        var statusBarHeight:CGFloat = 0
        if self.view.safeAreaInsets.bottom > 0 {
            statusBarHeight = 88
        } else {
            statusBarHeight = 64
        }
        self.pageView.setContentOffset(CGPoint(x: rect.origin.x, y: -statusBarHeight), animated: false)
    }
}

// MARK: System "Back" button action
extension DetailsViewController {
    
    override func navigationShouldPopMethod() -> Bool {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kScrollToCurrentNumberNotificatiin), object: currentIndexOfImage, userInfo: nil)
        return true
    }
}

// MARK: UIScrollViewDelegate
extension DetailsViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
         let currentOffsetX = scrollView.contentOffset.x
         let pageViewW = pageView.pageSize.width
         let page = Int(currentOffsetX / pageViewW)
         currentIndexOfImage = page
         pageController.currentPage = page % 10

         loadTatgetPage(tatgetPage: page)
         pageView.currentNumLable.text = "\(page + 1)"
      }
}
