//
//  AppDelegate.swift
//  Numbers
//
//  Created by yan feng on 2020/6/13.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit
import CoreData
 
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UISplitViewControllerDelegate {
    
    var window: UIWindow?
    var hostReachability:YFNetWorkReachability!
    let mainListTableViewController = MainListTableViewController()
    let detailsViewController = DetailsViewController()
    var disconnect:Bool = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let screen = UIScreen.main.bounds
        self.window = UIWindow.init(frame: screen)
        mainListTableViewController.detailViewController = detailsViewController
        
        let navigationController = UINavigationController(rootViewController: mainListTableViewController)
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            self.window!.rootViewController = navigationController
        } else {
            let split = UISplitViewController()
            split.delegate = self
            split.preferredDisplayMode = .allVisible
            let minimumWidth = min(split.view.bounds.width, split.view.bounds.height)
            split.minimumPrimaryColumnWidth = minimumWidth / 2;
            split.maximumPrimaryColumnWidth = minimumWidth;
            split.preferredPrimaryColumnWidthFraction = 0.5
            split.viewControllers = [navigationController, detailsViewController]
            self.window!.rootViewController = split
        }
        
        self.window?.makeKeyAndVisible()
        hostReachability = YFNetWorkReachability.forInternetConnection()
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(notification:)), name: NSNotification.Name.netWorkReachabilityChanged, object: hostReachability)
        hostReachability.startNotifier()
        return true
    }
    
        @objc func reachabilityChanged(notification:NSNotification){

        let currentReach = notification.object as! YFNetWorkReachability
        let netWorkStatus = currentReach.currentReachabilityStatus()
                   switch netWorkStatus {
                       case .notReachable:
                           print("no network")
                           showNetWorkErrorAlert()
                           break
                       case .unknown:
                           print("unknown")
                           break
                       case .WWAN2G:
                           reconnectedNetwork()
                           print("2g")
                           break
                       case .WWAN3G:
                           reconnectedNetwork()
                           print("3g")
                           break
                       case .WWAN4G:
                           reconnectedNetwork()
                           print("4g")
                           break
                       case .wiFi:
                           reconnectedNetwork()
                           print("wifi")
                           break
                       default:
                           break
                   }
        
    }
    
    deinit {
        print("AppDelegate--deinit")
        NotificationCenter.default.removeObserver(self)
        hostReachability.stopNotifier()
    }
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Numbers")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

// MARK: private function
extension AppDelegate{
    func reconnectedNetwork(){
        if disconnect {
            DispatchQueue.main.async {
                self.disconnect = false
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: kReconnectedNetworkNotification), object: nil, userInfo: nil)
            }
        }
    }
    
    func showNetWorkErrorAlert(){
        let alert = UIAlertController(title: "No Network", message: "Please check the Network", preferredStyle: .alert)
       let confirmButton = UIAlertAction(title: "OK", style: .default) { (action) in
            switch action.style{
                  case .default:
                  self.disconnect = true
                  break
            case .cancel:
                break
            case .destructive:
                break
            @unknown default:
                break
            }
        }
        alert .addAction(confirmButton)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
