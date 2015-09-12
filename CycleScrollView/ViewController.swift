//
//  ViewController.swift
//  CycleScrollView
//
//  Created by lu on 15/9/11.
//  Copyright (c) 2015年 lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, CycleScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        var imageView = UIImageView(image: UIImage(named: "1.jpg"))
        imageView.frame = self.view.bounds
        self.view.addSubview(imageView)
        
        var localImages = NSArray(objects: UIImage(named: "1.jpg")!, UIImage(named: "2.jpg")!, UIImage(named: "3.jpg")!, UIImage(named: "4.jpg")!, UIImage(named: "5.jpg")!, UIImage(named: "6.jpg")!)
        var scroll = CycleScrollView(frame: CGRect(x: 0, y: 200, width: self.view.bounds.size.width, height: 200))
        scroll.setupLocalImages(localImages)
        scroll.delegate = self
        var remoteImages = NSArray(objects: "http://img1.mm131.com/pic/1997/14.jpg", "http://img1.mm131.com/pic/1997/15.jpg", "http://img1.mm131.com/pic/1997/18.jpg", "http://img1.mm131.com/pic/1997/19.jpg")
        var scroll1 = CycleScrollView(frame: CGRect(x: 0, y: 400, width: self.view.bounds.size.width, height: 200))
        scroll1.setupRemoteImages(remoteImages)
        
        self.view.addSubview(scroll)
        self.view.addSubview(scroll1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func cycleScrollView(scrollView: CycleScrollView, didSelectItemAtIndex index: Int) {
        println("you pressed \(index)")
    }

}

