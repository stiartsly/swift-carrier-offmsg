//
//  GroupaListCell.swift
//  offmsg
//
//  Created by 李爱红 on 2019/8/12.
//  Copyright © 2019 李爱红. All rights reserved.
//

import UIKit

class GroupaListCell:  UITableViewCell {

    var icon: UIImageView?
    var userLable: UILabel?
    var red: UILabel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        creatUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func creatUI() -> Void {

        icon = UIImageView.init(image: UIImage(named: "local")!)
        self.contentView.addSubview(icon!)

        red = UILabel()
        red?.backgroundColor = UIColor.red
        red?.layer.cornerRadius = 5.0
        red?.layer.masksToBounds = true
        self.contentView.addSubview(red!)

        userLable = UILabel()
        userLable?.backgroundColor = UIColor.clear
        userLable?.text = "测试群组"
        userLable?.textAlignment = .left
        userLable!.sizeToFit()
        self.contentView.addSubview(userLable!)

        let line = UIView()
        line.backgroundColor = UIColor.lightGray
        self.contentView.addSubview(line)

        icon?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(12)
            make.width.height.equalTo(22)
            make.centerY.equalToSuperview()
        })

        red?.snp.makeConstraints({ (make) in
            make.right.equalTo(icon!.snp_right).offset(5)
            make.width.height.equalTo(10)
            make.top.equalTo(icon!.snp_top).offset(-5)
        })

        userLable?.snp.makeConstraints({ (make) in
            make.top.equalTo(icon!)
            make.left.equalToSuperview().offset(45)
            make.height.equalTo(20)
        })

        line.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview()
        }
    }

}
