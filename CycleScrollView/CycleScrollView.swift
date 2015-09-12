//
//  CycleScrollView.swift
//  CycleScrollView
//
//  Created by lu on 15/9/12.
//  Copyright (c) 2015年 lu. All rights reserved.
//

import UIKit

protocol CycleScrollViewDelegate{
    func cycleScrollView(scrollView: CycleScrollView, didSelectItemAtIndex index: Int)
}

class CycleScrollViewCell: UICollectionViewCell{
    var imageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.frame = bounds
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFill
        addSubview(imageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CycleScrollView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let cellIndentifier = "CycleCell"
    var mainView: UICollectionView!
    var flowLayout: UICollectionViewFlowLayout!
    var localImages = NSMutableArray()
    var remoteImagesUrl = NSMutableArray()
    var timerInterval: NSTimeInterval = 2.0
    var delegate: CycleScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        startTimer()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView(){
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.frame.size
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        mainView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        mainView.backgroundColor = UIColor.clearColor()
        mainView.pagingEnabled = true
        mainView.showsHorizontalScrollIndicator = false
        mainView.showsVerticalScrollIndicator = false
        mainView.registerClass(CycleScrollViewCell.classForCoder(), forCellWithReuseIdentifier: cellIndentifier)
        mainView.dataSource = self
        mainView.delegate = self
        self.addSubview(mainView)
    }
    
    func startTimer(){
        var timer = NSTimer(timeInterval: timerInterval, target: self, selector: "autoScroll", userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    func autoScroll(){
        var index = Int(mainView.contentOffset.x / self.frame.width)
        var nextIndex = index + 1
        var isEnd: Bool = false
        if nextIndex == getPageNumber(){
            nextIndex = 0
            isEnd = true
        }
        mainView.scrollToItemAtIndexPath(NSIndexPath(forItem: nextIndex, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: !isEnd)
    }
    
    func setupLocalImages(images: NSArray){
        localImages.addObjectsFromArray(images as [AnyObject])
    }
    
    func setupRemoteImages(imagesUrl: NSArray){
        remoteImagesUrl.addObjectsFromArray(imagesUrl as [AnyObject])
    }
    
    func getPageNumber() -> Int{
        if localImages.count > 0{
            return localImages.count
        }else if remoteImagesUrl.count > 0{
            return remoteImagesUrl.count
        }
        
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.cycleScrollView(self, didSelectItemAtIndex: indexPath.row)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getPageNumber()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIndentifier, forIndexPath: indexPath) as! CycleScrollViewCell
        
        if localImages.count > 0{
            cell.imageView.image = localImages[indexPath.row] as? UIImage
        }else{
            let url = NSURL(string: remoteImagesUrl[indexPath.row] as! String)
            cell.imageView.sd_setImageWithURL(url)
        }
        
        return cell
    }
}
