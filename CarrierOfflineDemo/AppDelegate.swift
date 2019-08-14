//
//  AppDelegate.swift
//  CarrierOfflineDemo
//
//  Created by 李爱红 on 2019/5/15.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//
//     func creatUI() -> WMPageController {
//        let viewsitem = [ FrientListViewController().classForCoder,GroupListViewController().classForCoder]
//        let viewsTitle=["好友", "群组"]
//
//        let pageVC  =  WMPageController(viewControllerClasses: viewsitem, andTheirTitles: viewsTitle)
//
//        pageVC.title="offMsg"
//        pageVC.menuItemWidth = 85   //每个 MenuItem 的宽度
//        //        pageVC.menuHeight = 50    //导航栏高度
//        pageVC.postNotification = true  //
//        pageVC.bounces = true
//        pageVC.titleSizeSelected = 13    //选中时的标题尺寸
//        pageVC.titleSizeNormal = 14      //非选中时的标题尺寸
//        //        pageVC.menuViewStyle = .line    //Menu view 的样式，默认为无下划线
//        pageVC.titleColorSelected = UIColor.red    //标题选中时的颜色, 颜色是可动画的.
//        pageVC.titleColorNormal = UIColor.black    //标题非选择时的颜色, 颜色是可动画的
//        //        pageVC.menuBGColor = UIColor.white        //导航栏背景色
//        return pageVC
//    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "send"
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.toolbarManageBehaviour = .byPosition

//        let page = creatUI()
//        let naviCV = UINavigationController(rootViewController: page)
//        self.window?.rootViewController = naviCV
//        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

