//
//  WSAnimationLoadingHUD.swift
//  WSAnimationLoadingHUD
//
//  Created by caiwenshu on 10/10/15.
//  Copyright (c) 2015 caiwenshu. All rights reserved.
//

import UIKit

class WSAnimationLoadingHUD: UIView {
    
    var  ball_1:UIView?
    var  ball_2:UIView?
    var  ball_3:UIView?
    
    let BALL_RADIUS:CGFloat = 20.0 //圆的直径
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        self.crtBgView()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func  ballView(frame:CGRect) -> UIView {
        
        var dView:UIView = UIView.new()
        dView.frame = frame
        dView.layer.cornerRadius = frame.width / 2.0 // 成为圆形
        dView.backgroundColor = self.ballColor()
        
        return dView
    }
    
    private func crtBgView()
    {
        var bgView:UIVisualEffectView  = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        bgView.alpha = 0.9
        bgView.frame = self.bounds
        bgView.layer.cornerRadius = BALL_RADIUS / 2.0
        bgView.clipsToBounds = true
        
        self.addSubview(bgView)
    }
    
    
    
    func ballColor() -> UIColor
    {
        return UIColor.redColor()
    }
    
    
    func showHUD()
    {
        
        var ballH:CGFloat = self.bounds.height / 2 - BALL_RADIUS * 0.5
        
        self.ball_1 = self.ballView(CGRectMake(self.bounds.width / 2 - BALL_RADIUS * 1.5, ballH, BALL_RADIUS, BALL_RADIUS))
        self .addSubview(self.ball_1!)
        
        self.ball_2 = self.ballView(CGRectMake(self.bounds.width / 2 - BALL_RADIUS * 0.5, ballH, BALL_RADIUS, BALL_RADIUS))
        self .addSubview(self.ball_2!)
        
        
        self.ball_3 = self.ballView(CGRectMake(self.bounds.width / 2 + BALL_RADIUS * 0.5, ballH, BALL_RADIUS, BALL_RADIUS))
        self .addSubview(self.ball_3!)
        
        
        self.rotationAnimation()
        
    }
    
    func hiddenHUD()
    {
        self.ball_1!.removeFromSuperview()
        self.ball_2!.removeFromSuperview()
        self.ball_3!.removeFromSuperview()
        
        self.removeFromSuperview()
        
    }
    
    
    private func rotationAnimation()
    {
        // 1.1 取得围绕中心轴的点
        var centerPoint:CGPoint = CGPointMake(self.bounds.width / 2, self.bounds.height / 2)
        
        // 1.2 获得第一个圆的中点
        var centerBall_1:CGPoint = CGPointMake(self.bounds.width / 2 - BALL_RADIUS, self.bounds.height / 2)
        
        // 1.3 获得第三个圆的中点
        var centerBall_3:CGPoint = CGPointMake(self.bounds.width / 2 + BALL_RADIUS, self.bounds.height / 2)
        
        // 2.1 第一个圆的曲线
        var path_ball_1:UIBezierPath = UIBezierPath()
        path_ball_1 .moveToPoint(centerBall_1)
        
        path_ball_1 .addArcWithCenter(centerPoint, radius: BALL_RADIUS, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI) * 2, clockwise: false)
        
        var path_ball_1_1:UIBezierPath = UIBezierPath()
        path_ball_1_1.addArcWithCenter(centerPoint, radius: BALL_RADIUS, startAngle: CGFloat(0), endAngle: CGFloat(M_PI), clockwise: false)
        
        path_ball_1 .appendPath(path_ball_1_1)
        
        
        // 2.2 第一个圆的动画
        
        var animation_ball_1:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        animation_ball_1.path = path_ball_1.CGPath
        animation_ball_1.removedOnCompletion = false
        animation_ball_1.fillMode = kCAFillModeForwards
        animation_ball_1.calculationMode = kCAAnimationCubic
        animation_ball_1.repeatCount = 1
        animation_ball_1.duration = 1.4
        animation_ball_1.delegate = self
        animation_ball_1.autoreverses = false
        animation_ball_1.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.ball_1?.layer .addAnimation(animation_ball_1, forKey: "rotation_1")
        
        
        //3.1第三个园的曲线
        var path_ball_3:UIBezierPath = UIBezierPath()
        path_ball_3 .moveToPoint(centerBall_3)
        
        path_ball_3.addArcWithCenter(centerPoint, radius: BALL_RADIUS, startAngle: CGFloat(0), endAngle: CGFloat(M_PI), clockwise: false)
        
        var path_ball_3_1:UIBezierPath = UIBezierPath()
        path_ball_3_1 .addArcWithCenter(centerPoint, radius: BALL_RADIUS, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI) * 2, clockwise: false)
        
        path_ball_3 .appendPath(path_ball_3_1)
        
        
        // 3.2 第三个圆的动画
        var animation_ball_3:CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "position")
        animation_ball_3.path = path_ball_3.CGPath
        animation_ball_3.removedOnCompletion = false
        animation_ball_3.fillMode = kCAFillModeForwards
        animation_ball_3.calculationMode = kCAAnimationCubic
        animation_ball_3.repeatCount = 1
        animation_ball_3.duration = 1.4
        animation_ball_3.autoreverses = false
        animation_ball_3.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        self.ball_3?.layer .addAnimation(animation_ball_3, forKey: "rotation_3")
        
    }
    
    //animation  delegate callback
    override func animationDidStart(anim: CAAnimation!)
    {
        UIView.animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
            
            self.ball_1?.transform = CGAffineTransformMakeTranslation(-self.BALL_RADIUS, 0)
            self.ball_1?.transform = CGAffineTransformScale(self.ball_1!.transform, 0.7, 0.7)
            
            self.ball_2?.transform = CGAffineTransformScale(self.ball_2!.transform, 0.7, 0.7)
            
            self.ball_3?.transform = CGAffineTransformMakeTranslation(self.BALL_RADIUS, 0)
            self.ball_3?.transform = CGAffineTransformScale(self.ball_3!.transform, 0.7, 0.7)
            
            }) { (finished) -> Void in
                
                UIView .animateWithDuration(0.3, delay: 0.1, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.BeginFromCurrentState, animations: { () -> Void in
                    
                    self.ball_1?.transform = CGAffineTransformIdentity
                    self.ball_2?.transform = CGAffineTransformIdentity
                    self.ball_3?.transform = CGAffineTransformIdentity
                    
                    }, completion: nil)
                
                
                
        }
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        
        if(flag)
        {
            self.rotationAnimation()
        }
        
    }
    
}
