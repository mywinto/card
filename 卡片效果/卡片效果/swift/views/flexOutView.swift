//
//  flexOutView.swift
//  卡片效果
//
//  Created by YHIOS on 2020/10/29.
//  Copyright © 2020 CES. All rights reserved.
//

import UIKit
import FlexLayout
class flexOutView: UIView {
    
    lazy var rootFlexContainer:UIView = {
        let view = UIView.init()
        self.addSubview(view)
        return view
    }()
    lazy var leftView:UIView = {
        let view = UIView.init()
        return view
    }()
    lazy var centerView:UIView = {
        let view = UIView.init()
        return view
    }()
    lazy var rightView:UIView = {
        let view = UIView.init()
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setFrames()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setFrames() {
        rootFlexContainer.flex.direction(.row).alignItems(.center).justifyContent(.center).define { [weak self](flex) in
            flex.addItem(self!.leftView).aspectRatio(1).height(50)
            flex.addItem(self!.rightView).width(50).height(50)
            flex.addItem(self!.centerView).width(50).height(50)
        }
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.rootFlexContainer.flex.layout()
        
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
