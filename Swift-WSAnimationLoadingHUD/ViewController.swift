//
//  ViewController.swift
//  Swift-WSAnimationLoadingHUD
//
//  Created by caiwenshu on 10/10/15.
//  Copyright (c) 2015 caiwenshu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var loadingHud:WSAnimationLoadingHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var bgImageView:UIImageView = UIImageView(image: UIImage(named: "001.png"))
        self.view .addSubview(bgImageView)
        
        self.loadingHud = WSAnimationLoadingHUD(frame: CGRectMake(85, 80, 150, 150))
        self.view .addSubview(self.loadingHud!)
        
        self.loadingHud!.showHUD()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if((self.loadingHud?.superview) != nil)
        {
            self.loadingHud!.hiddenHUD()
        } else {
            self.view .addSubview(self.loadingHud!)
            self.loadingHud!.showHUD()
        }
        
        
    }

}

