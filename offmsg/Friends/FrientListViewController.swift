//
//  FrientListViewController.swift
//  offmsg
//
//  Created by 李爱红 on 2019/8/12.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit
import SnapKit
import ElastosCarrierSDK

enum handleFriendType {
    case handleFriendTypeInfoChange
    case handleFriendTypeStatuChange
    case handleFriendTypeRemove
    case handleFriendTypeAdd
}

var friendList = [UserInfo]()
class FrientListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var mainTableView: UITableView!
    var myInfo: UserInfo?
    var newMsgs = [MessageInfo]()

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: .deviceStatusChanged, object: nil, queue: OperationQueue.main) { [unowned self] _ in
            self.myInfo?.name = try? DeviceManager.sharedInstance.carrierInst.getSelfUserInfo().name
            self.myInfo?.userId = try? DeviceManager.sharedInstance.carrierInst.getSelfUserInfo().userId
            self.myInfo?.remote = false
            self.myInfo?.isNews = false
            self.myInfo?.status = DeviceManager.sharedInstance.status
            self.mainTableView?.reloadData()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(handleDeviceListChanged(notif:)), name: .deviceListChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendInfoChanged(notif:)), name: .friendInfoChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendStatusChanged(notif:)), name: .friendStatusChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFriendAdded(notif:)), name: .friendAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleDidReceiveFriendMessage(notif:)), name: .didReceiveFriendMessage, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleAlready(notif:)), name: Notification.Name("already"), object: nil)

        DeviceManager.sharedInstance.start()
        configData()
        creatTableView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .showAddFriendOrCreateGroup, object: false)
    }

    func configData() {
        myInfo = UserInfo()
        myInfo!.name = "本机"
        myInfo!.remote = false
        myInfo!.status = DeviceManager.sharedInstance.status
        friendList.append(myInfo!)
    }

    func creatTableView() {

        mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        mainTableView.delegate = self as UITableViewDelegate
        mainTableView.dataSource = self as UITableViewDataSource
        mainTableView.estimatedRowHeight = 50
        mainTableView.estimatedSectionHeaderHeight = 395;
        mainTableView.estimatedSectionFooterHeight = 0;
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.rowHeight = 56
        mainTableView.separatorStyle = .none
        mainTableView.register(CarrierListCell.self, forCellReuseIdentifier: "CarrierListCell")
        self.view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview().offset(-49)
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:CarrierListCell = tableView.dequeueReusableCell(withIdentifier: "CarrierListCell") as! CarrierListCell
        cell.model = friendList[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row != 0 {
            let carrierVC = CarrierChatViewController()
            carrierVC.friendId = friendList[indexPath.row].userId
            carrierVC.myId = myInfo?.userId
            if friendList[indexPath.row].isNews == true {
                friendList[indexPath.row].isNews = false
                carrierVC.newMsgs = friendList[indexPath.row].newMsgs
                friendList[indexPath.row].newMsgs.removeAll()
                self.mainTableView.reloadRows(at: [indexPath], with: .none)
            }
            self.navigationController?.pushViewController(carrierVC, animated: true)
        }
    }

    //MARK: NSNotification action
    @objc func handleDeviceListChanged(notif: NSNotification) {
        let friends = notif.userInfo!["friends"]
        friendList = friends as! [UserInfo]
        friendList.insert(myInfo!, at: 0)
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }
    @objc func handleFriendInfoChanged(notif: NSNotification) {
        let friend = notif.userInfo!["friendInfo"] as! CarrierFriendInfo
        handleFriendInfo(friend, .handleFriendTypeInfoChange)
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }

    @objc func handleFriendStatusChanged(notif: NSNotification) {
        let friend = notif.userInfo!["friendInfo"] as! UserInfo
        handleFriendStatusChange(friend)
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }

    @objc func handleFriendAdded(notif: NSNotification) {
        let friend = notif.userInfo!["friendInfo"] as! CarrierFriendInfo
        handleFriendInfo(friend, .handleFriendTypeAdd)
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }

    @objc func handleDidReceiveFriendMessage(notif: NSNotification) {
        let friend = notif.userInfo!["messageInfo"] as! Dictionary<String, Any>
        for value in friendList {
            if value.userId == (friend["userId"] as! String) {
                value.isNews = true
                let msg = MessageInfo()
                msg.friendId = value.userId
                msg.message = (friend["msg"] as! String)
                msg.isMy = false
                msg.status = true
                value.newMsgs.append(msg)
            }
        }
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }

    @objc func handleAlready(notif: NSNotification) {
        let friend = notif.userInfo!["msgInfo"] as! MessageInfo
        for value in friendList {
            if value.userId == friend.friendId {
                value.isNews = false
                value.newMsgs.removeAll()
            }
        }
        DispatchQueue.main.sync {
            self.mainTableView .reloadData()
        }
    }

    func handleFriendStatusChange(_ friend: UserInfo) {
        for value in friendList {
            if value.userId == friend.userId {
                value.remote = true
                value.status = friend.status
            }
        }
    }

    func handleFriendInfo(_ friend: CarrierFriendInfo, _ type: handleFriendType) {

        switch type {
        case .handleFriendTypeInfoChange:
            for value in friendList {
                if value.userId == friend.userId {
                    value.name = friend.name
                    value.remote = true
                }
            }
            break
        case .handleFriendTypeStatuChange:
            for value in friendList {
                if value.userId == friend.userId {
                    value.remote = true
                    value.status = friend.status
                }
            }
            break
        case .handleFriendTypeRemove:
            for value in friendList {
                if value.userId == friend.userId {
                    let newArr = friendList.filter{$0 != value}
                    friendList = newArr
                }
            }
            break
        case .handleFriendTypeAdd:
            let fd = UserInfo()
            fd.name = friend.name
            if friend.name == "" {
                fd.name = friend.userId
            }
            fd.userId = friend.userId
            fd.remote = true
            fd.status = friend.status
            fd.isNews = false
            friendList.append(fd)
            break
        }
    }
}

