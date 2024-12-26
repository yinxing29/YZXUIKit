//
//  YZXScrollViewController.swift
//  YZXUIKit_Example
//
//  Created by meipian on 2024/12/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import YZXUIKit

class YZXScrollViewController: UIViewController {
    
    private lazy var scrollView: YZXScrollView = {
        let scroll = YZXScrollView(frame: CGRect(x: 0.0, y: 0.0, width: YZXDevice.screenWidth, height: YZXDevice.screenHeight - YZXDevice.safeBottomHeight - YZXDevice.topHeight))
        scroll.backgroundColor = .yellow
        scroll.customIndicatorStyle = .alwaysShow
        scroll.indicatorColor = .orange
        scroll.indicatorInset = UIEdgeInsets(top: 10.0, left: 0.0, bottom: 10.0, right: 10.0)
        scroll.indicatorWidth = 6.0
        scroll.indicatorHeight = 100.0
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.navigationBar.isTranslucent = false
        p_initView()
    }
    
    //MARK: --------------------------- init ---------------------------
    private func p_initView() {
        view.addSubview(scrollView)
        
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
        for idx in 0..<10 {
            let view = UIView(frame: CGRect(x: 0.0, y: 100.0 * CGFloat(idx), width: UIScreen.main.bounds.width, height: 100.0))
            view.backgroundColor = .init(red: CGFloat(arc4random() % 255) / 255.0, green: CGFloat(arc4random() % 255) / 255.0, blue: CGFloat(arc4random() % 255) / 255.0, alpha: 1.0)
            scrollView.addSubview(view)
        }
    }
    //MARK: --------------------------- init END ---------------------------
}
