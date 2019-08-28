//
//  GroupChatViewController.swift
//  offmsg
//
//  Created by 李爱红 on 2019/8/12.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit

class GroupChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var mainTableView: UITableView!
    var chatInputView: UITextView?
    var chatList = [MessageInfo]()
    var currentGroup: CarrierGroup!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        creatUI()
        let item=UIBarButtonItem(title: "邀请", style: UIBarButtonItem.Style.plain, target: self, action: #selector(inviteFrient))
        self.navigationItem.rightBarButtonItem = item
    }

    func creatUI() {

        mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        mainTableView.delegate = self as UITableViewDelegate
        mainTableView.dataSource = self as UITableViewDataSource
        mainTableView.estimatedRowHeight = 50
        mainTableView.estimatedSectionHeaderHeight = 395;
        mainTableView.estimatedSectionFooterHeight = 0;
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.separatorStyle = .none
        mainTableView.register(MyChatCell.self, forCellReuseIdentifier: "MyChatCell")
        mainTableView.register(FriendChatCell.self, forCellReuseIdentifier: "FriendChatCell")
        self.view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-50)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview().offset(-89)
            }
        }
        chatInputView = UITextView()
        chatInputView?.backgroundColor = UIColor.white
        chatInputView?.layer.masksToBounds = true
        chatInputView?.layer.cornerRadius = 10
        self.view.addSubview(chatInputView!)
        chatInputView?.snp.makeConstraints({ (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                // Fallback on earlier versions
                make.bottom.equalToSuperview().offset(-49 - 4)
            }
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12 - 44)
            make.height.equalTo(44)
        })
    }

    //    MARK: - button Action
    @objc func inviteFrient() {

        let inviteFriend  = InviteToGroupViewController()
        inviteFriend.currentGroup = currentGroup
        self.navigationController?.pushViewController(inviteFriend, animated: true)
    }

    //    MARK: - TableviewDelgate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let myCell: MyChatCell = tableView.dequeueReusableCell(withIdentifier: "MyChatCell") as! MyChatCell
        let frendCell: FriendChatCell = tableView.dequeueReusableCell(withIdentifier: "FriendChatCell") as! FriendChatCell
        if chatList[indexPath.row].isMy! {
            myCell.model = chatList[indexPath.row]
            return myCell
        }
        frendCell.model = chatList[indexPath.row]
        return frendCell
    }
}
