//
//  YZXMainViewController.swift
//  YZXUIKit_Example
//
//  Created by meipian on 2024/12/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class YZXMainViewController: UIViewController {
    
    private let kYZXUIkitMainPageCellIdentify = "kYZXUIkitMainPageCellIdentify"
    
    private lazy var dataSource: [[String: Any]] = {
        return []
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableViewAutomaticDimension
        table.estimatedRowHeight = 60.0
        
        table.register(YZXMainTableViewCell.self, forCellReuseIdentifier: kYZXUIkitMainPageCellIdentify)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        p_settingNavigationBar()
        p_initData()
        p_initView()
    }
    
    //MARK: --------------------------- init ---------------------------
    private func p_settingNavigationBar() {
        navigationItem.title = "YZXUIKit"
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func p_initData() {
        dataSource = [
            [
                "title": "自定义ScrollView（滚动条自定义）",
                "controller": "YZXUIKit_Example.YZXScrollViewController"
            ]
        ]
    }
    
    private func p_initView() {
        view.addSubview(tableView)
    }
    //MARK: --------------------------- init END ---------------------------
}

extension YZXMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kYZXUIkitMainPageCellIdentify, for: indexPath) as! YZXMainTableViewCell
        cell.textLab.text = dataSource[indexPath.row]["title"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let classStr = dataSource[indexPath.row]["controller"] as? String, let vcClass = NSClassFromString(classStr) as? UIViewController.Type else {
            return
        }
        
        navigationController?.pushViewController(vcClass.init(), animated: true)
    }
}
