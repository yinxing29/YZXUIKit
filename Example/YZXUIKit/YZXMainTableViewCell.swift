//
//  YZXMainTableViewCell.swift
//  YZXUIKit_Example
//
//  Created by meipian on 2024/12/26.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class YZXMainTableViewCell: UITableViewCell {
    
    private(set) lazy var textLab: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.numberOfLines = 0
        lab.font = UIFont.systemFont(ofSize: 18.0)
        lab.textColor = .black
        return lab
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        p_initView()
    }
    
    //MARK: --------------------------- init ---------------------------
    private func p_initView() {
        textLab.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(textLab)
        
        NSLayoutConstraint.activate([
            textLab.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12.0),
            textLab.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12.0),
            textLab.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0),
            textLab.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16.0),
        ])
    }
    //MARK: --------------------------- init END ---------------------------
}
