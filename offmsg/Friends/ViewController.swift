//
//  ViewController.swift
//  offmsg
//
//  Created by 李爱红 on 2019/5/15.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit
import SnapKit
import ElastosCarrierSDK
import WMPageController

class ViewController: WMPageController {

    let vcs = [FrientListViewController(), GroupListViewController()]
    let tts: Array<String> = ["好友", "群组"]
    var item: UIBarButtonItem!


    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        createNavigItem()
        NotificationCenter.default.addObserver(self, selector: #selector(showAddFOrCgroup(_ : )), name: .showAddFriendOrCreateGroup, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func createNavigItem() {
        let img = UIImage(named: "user")
        let item0 = UIBarButtonItem(image: img, style: UIBarButtonItem.Style.plain, target: self, action: #selector(qrcode))
        self.navigationItem.leftBarButtonItem = item0
    }

    func showfriedOrCreatGroup(_ isCreat: Bool) {
        if isCreat {
            item = UIBarButtonItem(title: "建组", style: UIBarButtonItem.Style.plain, target: self, action: #selector(creatGroup))
            self.navigationItem.rightBarButtonItem = item
        }
        else {
            item = UIBarButtonItem(title: "添加", style: UIBarButtonItem.Style.plain, target: self, action: #selector(addDevice))
            self.navigationItem.rightBarButtonItem = item
        }
    }

    //    MARK: action
    @objc func addDevice() {
        let scanVC = ScanViewController();
        self.navigationController?.show(scanVC, sender: nil)
    }

    @objc func creatGroup() {
        _ = DeviceManager.sharedInstance.creatCarrierGroup()
    }

    @objc func qrcode() {
        let myInfoVC = MyInfoViewController()
        self.navigationController?.pushViewController(myInfoVC, animated: true)
    }

    @objc func showAddFOrCgroup(_ sender: Notification) {
        let sendeValue = sender.object as! Bool
        showfriedOrCreatGroup(sendeValue)
    }

    //MARK: pageController delegate
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        return vcs[index]
    }
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        return vcs.count
    }

    override func menuView(_ menu: WMMenuView!, titleAt index: Int) -> String! {
        return tts[index]
    }
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 40)
    }

    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: 40, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 40)
    }
}

