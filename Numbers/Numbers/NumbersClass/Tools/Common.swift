//
//  Common.swift
//  Numbers
//
//  Created by yan feng on 2020/6/14.
//  Copyright © 2020 Yan feng. All rights reserved.
//

import UIKit

let kScreenSize = UIScreen.main.bounds
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height

let kReconnectedNetworkNotification = "kReconnectedNetworkNotification"
let kScrollToCurrentNumberNotificatiin = "kSrollerToCurrentNumberNotificatiin"

// Real device or Simulator
struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }()
}
