//
//  GroupListViewController.swift
//  offmsg
//
//  Created by 李爱红 on 2019/8/12.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit

class GroupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CarrierGroupDelegate {
    var mainTableView: UITableView!
    var dataSource: Array<CarrierGroup> = []
    var frientGroup: CarrierGroup!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        creatUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.post(name: .showAddFriendOrCreateGroup, object: true)
        getGroups()
        addNotification()
    }

    func creatUI() {

        mainTableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.estimatedSectionHeaderHeight = 395;
        mainTableView.estimatedSectionFooterHeight = 0;
        mainTableView.rowHeight = UITableView.automaticDimension
        mainTableView.rowHeight = 55
        mainTableView.separatorStyle = .none

        mainTableView.register(GroupaListCell.self, forCellReuseIdentifier: "GroupaListCell")
        self.view.addSubview(mainTableView)

        mainTableView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()

            if #available(iOS 11.0, *) {
                make.bottom.equalTo(view.safeAreaLayoutGuide)
            } else {
                make.bottom.equalToSuperview().offset(-49)
            }
        }
    }
    func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGroupList(_:)), name: .didcreatGroupSuccee, object: nil)
    }
    //MARK: - func
    func getGroups() {
        do {
            self.dataSource = try (Carrier.sharedInstance()?.getGroups())!
            self.mainTableView.reloadData()
        } catch {
            print(error)
        }
    }

    //    MARK: - Notification Action
    @objc func refreshGroupList(_ sender: Notification) {
            getGroups()
    }

    //    MARK: - tableviewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: GroupaListCell = tableView.dequeueReusableCell(withIdentifier: "GroupaListCell") as! GroupaListCell
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let carrierVC = GroupChatViewController()
        carrierVC.currentGroup = dataSource[indexPath.row]
        self.navigationController?.pushViewController(carrierVC, animated: true)
    }

}
