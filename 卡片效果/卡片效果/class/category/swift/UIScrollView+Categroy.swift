//
//  UIScrollView+Categroy.swift
//  yihuo
//
//  Created by YHIOS on 2020/8/17.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import Foundation
extension UIViewController{
    
    // #pragma markJ
    
    func setScrollViewPostion(scrollView:UIScrollView,detailView:UIView,topH:CGFloat){
        if (scrollView.contentOffset.y <= 0) {
            if (detailView.y - scrollView.contentOffset.y < topH){
                
            }else{
                detailView.y = detailView.y - scrollView.contentOffset.y;
                          scrollView.contentOffset  = CGPoint(x: 0, y: 0 );
            }
          
        }else if (detailView.y > topH) {
            if (detailView.y - scrollView.contentOffset.y < topH){
                           
            }else{
                detailView.y = detailView.y - scrollView.contentOffset.y;
                 scrollView.contentOffset  = CGPoint(x: 0, y: 0 );
            }
          
        }else if(detailView.y != topH){
              detailView.y = topH;
        }
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - detailView: 需要移动的view
    ///   - topH:需要移动的view frame y
    ///   - pointView: pan相对postion view
    func setPanViewPostion(detailView:UIView,topH:CGFloat,pointView:UIView,sender:UIPanGestureRecognizer){
        let transP = sender.translation(in: pointView)
        var y = transP.y + topH
        if y < topH {
            y = topH
        }
        detailView.y = y
          
       }
    func setFinishDetialViewPosition(detailView:UIView,topH:CGFloat,finishBlock:@escaping(()->())){
        var p:CGFloat = 0;
        if detailView.y > topH + (kScreenHeight - topH)/3{
            p = kScreenHeight
        }else{
            p = topH
            if detailView.y < topH {
                 detailView.y = p
                return
            }
        }
        UIView.animate(withDuration: 0.3, animations: {
            detailView.y = p
        }) { (finish) in
            if(p != topH){
                finishBlock()
            }
        }
    }
    
    
}
