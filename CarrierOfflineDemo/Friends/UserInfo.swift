//
//  UserInfo.swift
//  CarrierOfflineDemo
//
//  Created by 李爱红 on 2019/5/15.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit
import ElastosCarrierSDK

class UserInfo: NSObject {

    var name: String?
    var status = CarrierConnectionStatus.Disconnected;
    var remote: Bool?
    var userId: String?
    var isNews: Bool?
    var newMsgs = [MessageInfo]()

}

