//
//  MainListTableViewController.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

class MainListTableViewController: UITableViewController {
    
    private let mainListTableViewCellID = "MainListTableViewCellID"

    var detailViewController:DetailsViewController!
    
    fileprivate lazy var numberVM : MainListViewModel = MainListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(MainListTableViewCell.self, forCellReuseIdentifier: mainListTableViewCellID)
        
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reconnectNetWork), name:  NSNotification.Name(rawValue: kReconnectedNetworkNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(srollToCurrentNumber(notification:)), name: NSNotification.Name(rawValue: kScrollToCurrentNumberNotificatiin), object: nil)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: Loading data function
extension MainListTableViewController {
    @objc func loadData() {
        self.tableView.isUserInteractionEnabled = false
        numberVM.loadNumberData(type: .get, urlString: "http://dev.tapptic.com/test/json.php") {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isUserInteractionEnabled = true
            }

        }
    }
}

// MARK: Private function
extension MainListTableViewController {
    @objc func srollToCurrentNumber(notification:NSNotification) {
        let index = notification.object as! Int
        let indexPath = IndexPath(row: index, section: 0)
        tableView.scrollToRow(at: indexPath, at: .middle, animated: true)
    }
    @objc func reconnectNetWork(){
        if numberVM.NumbersGroups.count == 0 {
            loadData()
        } else {
            tableView.reloadData()
        }
    }
}

// MARK: - Table view data source
extension MainListTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return numberVM.NumbersGroups.count
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mainListTableViewCellID, for: indexPath) as! MainListTableViewCell
        cell.numberLabel.text = numberVM.NumbersGroups[indexPath.row].name
        cell.numberImage.YF_WebImage(url: numberVM.NumbersGroups[indexPath.row].image, defaultImage: "placeholder")
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if appDelegate.disconnect {
            appDelegate.showNetWorkErrorAlert()
        } else {
            if (UIDevice.current.userInterfaceIdiom == .phone) {
                detailViewController = DetailsViewController()
                detailViewController.currentIndexOfImage = indexPath.row
                detailViewController.numberViewModel = numberVM
                detailViewController.imageGroupCount = numberVM.NumbersGroups.count
                detailViewController.currentNameOfNumber = numberVM.NumbersGroups[indexPath.row].name
                self.tableView!.deselectRow(at: indexPath, animated: true)
                self.navigationController!.pushViewController(detailViewController, animated:true)
                
            } else {
                detailViewController = appDelegate.detailsViewController
                detailViewController.currentNameOfNumber = numberVM.NumbersGroups[indexPath.row].name
                detailViewController.loadingData(currentPage: indexPath.row)
            }
        }
        
        
       
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
