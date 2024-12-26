//
//  YZXScrollView.swift
//  YZXUIKit
//
//  Created by meipian on 2024/12/26.
//

import Foundation

@objc public enum YZXScrollViewIndicatorStyle: Int {
    case `default`
    case notShow
    case alwaysShow
}

@objcMembers public class YZXScrollView: UIScrollView {
    
    /// 滚动条类型
    public var customIndicatorStyle = YZXScrollViewIndicatorStyle.default
    
    /// 滚动条颜色
    public var indicatorColor: UIColor? = .black.withAlphaComponent(0.5) {
        didSet {
            indicatorView.backgroundColor = indicatorColor ?? .black.withAlphaComponent(0.5)
        }
    }
    
    /// 滚动条外间距
    public var indicatorInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 1.0)
    
    /// 滚动条宽度，当设置为0.0时，会取默认值
    public var indicatorWidth = 3.0 {
        didSet {
            indicatorView.layer.cornerRadius = indicatorWidth / 2.0
        }
    }
    
    /// 滚动条高度，默认为scrollView高度的0.75，当设置为0.0时，会取默认值
    public var indicatorHeight = 0.0
    
    /// 滚动条最小高度
    public var indicatorMinHeight = 10.0
    
    private weak var externalDelegate: UIScrollViewDelegate?
    
    private lazy var indicatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = indicatorColor
        view.layer.cornerRadius = indicatorWidth / 2.0
        view.alpha = 0.0
        return view
    }()
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        
        super.delegate = self
        contentInsetAdjustmentBehavior = .never
        
        indicatorHeight = frame.size.height * 0.75
        p_initView()
        
        calculateIndicatorLocation()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        if indicatorHeight <= 0.0 {
            indicatorHeight = frame.size.height * 0.75
        }
    }
    
    //MARK: --------------------------- init ---------------------------
    private func p_initView() {
        addSubview(indicatorView)
    }
    //MARK: --------------------------- init END ---------------------------
    
    public override var delegate: (any UIScrollViewDelegate)? {
        get {
            return externalDelegate
        }
        set {
            externalDelegate = newValue
        }
    }
    
    public override func addSubview(_ view: UIView) {
        super.addSubview(view)
        
        bringSubviewToFront(indicatorView)
    }
    
    public override var contentSize: CGSize {
        didSet {
            calculateIndicatorLocation()
        }
    }
    
    // 计算滚动条位置
    private func calculateIndicatorLocation() {
        let contentHeight = contentSize.height
        let visibleHeight = frame.height
        
        if indicatorHeight <= 0.0 {
            indicatorHeight = visibleHeight * 0.75
        }
        
        if indicatorWidth <= 0.0 {
            indicatorWidth = 3.0
        }
        
        var height = max(indicatorHeight, indicatorMinHeight)
        // 计算滚动条的位置
        var yOffset = (visibleHeight - height) * contentOffset.y / (contentHeight - visibleHeight) + contentOffset.y
        
        // 滑到顶部外
        if contentOffset.y <= 0.0 {
            height += yOffset
            yOffset = contentOffset.y
            
            if height < indicatorMinHeight {
                height = indicatorMinHeight
            }
            
            yOffset += indicatorInset.top
        }else if contentOffset.y >= contentHeight - visibleHeight { // 滑倒底部外
            let changeHeight = (contentHeight - (yOffset + height))
                        
            height += changeHeight
            yOffset = contentOffset.y + visibleHeight - height
            
            if height < indicatorMinHeight {
                height = indicatorMinHeight
                yOffset = contentOffset.y + visibleHeight - height
            }
            
            yOffset -= indicatorInset.bottom
        }
        
        indicatorView.frame = CGRect(x: frame.width - indicatorWidth - indicatorInset.right, y: yOffset, width: indicatorWidth, height: height)
        
        if customIndicatorStyle == .alwaysShow {
            indicatorView.alpha = 1.0
        }else if customIndicatorStyle == .notShow {
            indicatorView.alpha = 0.0
        }
    }
}

extension YZXScrollView: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculateIndicatorLocation()
                
        if customIndicatorStyle == .default {
            indicatorView.alpha = 1.0
        }
        
        externalDelegate?.scrollViewDidScroll?(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 停止类型1、停止类型2
        if (!scrollView.isTracking &&
            !scrollView.isDragging &&
            !scrollView.isDecelerating) {
            scrollViewDidEndScroll()
        }
        
        externalDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (!decelerate) {
            // 停止类型3
            let dragToDragStop = scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating;
            if (dragToDragStop) {
                scrollViewDidEndScroll()
            }
        }
        
        externalDelegate?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate)
    }
    
    private func scrollViewDidEndScroll() {
        if customIndicatorStyle == .default {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                UIView.animate(withDuration: 0.3) {
                    self.indicatorView.alpha = 0.0 // 渐隐滚动条
                }
            }
        }
    }
}
