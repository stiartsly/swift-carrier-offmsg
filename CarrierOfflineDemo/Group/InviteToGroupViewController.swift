//
//  InviteToGroupViewController.swift
//  CarrierOfflineDemo
//
//  Created by 李爱红 on 2019/8/14.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit

class InviteToGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var mainTableView: UITableView!
    var dataSource: Array<UserInfo> = []
    var currentGroup: CarrierGroup!

    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
        let item=UIBarButtonItem(title: "确定", style: UIBarButtonItem.Style.plain, target: self, action: #selector(sureAction))
        self.navigationItem.rightBarButtonItem = item
        getFriendList()
    }

    func creatUI() {
        mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 55
        mainTableView.separatorStyle = .none
        mainTableView.register(InviteToGroupCell.self, forCellReuseIdentifier: "InviteToGroupCell")
        mainTableView.allowsMultipleSelection = true
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

    @objc func sureAction() {
        var selectIndexs = [Int]()
        if let selectItem = mainTableView.indexPathsForSelectedRows {
            for indexPath in selectItem {
                selectIndexs.append(indexPath.row)
            }
        }
        print("选中列表索引值为：", selectIndexs)
        print("选中项的值为:")

        for index in selectIndexs {
            do {
                let frientId: String = dataSource[index].userId ?? ""
                try currentGroup.inviteFriend(frientId)
            } catch {
                print("Invite frient ===", error)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }

    func getFriendList() {
        dataSource = friendList
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: InviteToGroupCell = tableView.dequeueReusableCell(withIdentifier: "InviteToGroupCell") as! InviteToGroupCell
        cell.model = dataSource[indexPath.row]
        if tableView.indexPathsForSelectedRows?.firstIndex(of: indexPath) != nil {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(tableView)
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = mainTableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }


}
