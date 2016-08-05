//
//  SwiftCtoller.swift
//  MySecondProduct
//
//  Created by chengwen on 16/2/23.
//  Copyright © 2016年 Shenzhen Tentinet Technology Co,. Ltd. All rights reserved.
//

import UIKit

class SwiftCtoller: UIViewController {
    var openBtn:UIButton!
    
    
    override func viewDidLoad() {
        self.title = "呵呵";
        self.view.backgroundColor = UIColor.lightGrayColor()
        let view = UIView()
        view.backgroundColor = UIColor.redColor()
        view.frame = CGRectMake(10, 0, 300, 100)
        
        self.view.addSubview(view)
        
        self.openBtn = UIButton.init(frame: CGRectMake(0, 103, 60, 40))
        self.openBtn.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.openBtn)
        self.openBtn.addTarget(self, action: ("action_open"), forControlEvents: .TouchUpInside)
        
        
        
        
        
        
    }
    
    
     func action_open()
    {
        let appdelegate:AppDelegate =  UIApplication .sharedApplication().delegate as! AppDelegate
        appdelegate.drawerVC .openDrawerSide(.Left, animated: true, completion: nil);
        
        
    }
}
