//
//  YZXDevice.swift
//  YZXUIKit_Example
//
//  Created by meipian on 2024/12/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation

@objcMembers public class YZXDevice: NSObject {
    
    public static let keyWindow: UIWindow? = UIApplication.shared.delegate?.window ?? UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first
    
    public static let safeBottomHeight: CGFloat = keyWindow?.safeAreaInsets.bottom ?? 0.0
    
    public static let statusHeight: CGFloat = keyWindow?.safeAreaInsets.top ?? 20.0
    
    public static let topHeight: CGFloat = statusHeight + 44.0
    
    public static let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    public static let screenHeight: CGFloat = UIScreen.main.bounds.height
}
