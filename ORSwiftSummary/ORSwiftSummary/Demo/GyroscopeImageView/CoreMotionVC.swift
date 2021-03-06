//
//  CoreMotionVC.swift
//  ORSwiftSummary
//
//  Created by orilme on 2020/10/16.
//  Copyright © 2020 orilme. All rights reserved.
//

import UIKit

let kMultimediaPreviewViewHeight: CGFloat = 300

class CoreMotionVC: UIViewController, UIScrollViewDelegate {
    
    private lazy var imageView: GyroscopeImageView = {
        let imageView = GyroscopeImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.WIDTH, height: kMultimediaPreviewViewHeight)
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: UIScreen.NAVHEIGHT, width: UIScreen.WIDTH, height: UIScreen.HEIGHT - UIScreen.NAVHEIGHT)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var vrLabel: UILabel = {
        let label = UILabel()
        label.text = "下拉进入VR"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        
        scrollView.backgroundColor = .purple
        view.addSubview(scrollView)
        
        vrLabel.frame = CGRect(x: UIScreen.WIDTH/2 - 50, y: UIScreen.SafeAreaInsetsTop, width: 100, height: 40)
        imageView.addSubview(vrLabel)
        
        imageView.backgroundColor = .red
        imageView.moveImgView.image = UIImage.init(named: "img_back")
        scrollView.addSubview(imageView)
        imageView.setMoveImgViewFrame(width: UIScreen.WIDTH, height: kMultimediaPreviewViewHeight)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            print("scrollViewDidScroll---", offsetY)
            vrLabel.isHidden = offsetY > -50
            self.imageView.mj_y = offsetY
            self.imageView.mj_h = abs(offsetY) + kMultimediaPreviewViewHeight
            self.imageView.setMoveImgViewFrame(width: UIScreen.WIDTH, height: abs(offsetY) + kMultimediaPreviewViewHeight)
        }
           
        if offsetY < -kMultimediaPreviewViewHeight / 2 {
            vrLabel.text = "欢迎进入VR"
        }else {
            vrLabel.text = "下拉进入VR"
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewDidEndDecelerating---", scrollView.contentOffset.y, -kMultimediaPreviewViewHeight / 2)
        guard scrollView.contentOffset.y < -kMultimediaPreviewViewHeight / 2 else { return }
        self.vrLabel.isHidden = true
        self.navigationController?.pushViewController(CoreMotionVC(), animated: true)
        self.imageView.mj_y = 0
        self.imageView.mj_h = kMultimediaPreviewViewHeight
        self.imageView.setMoveImgViewFrame(width: UIScreen.WIDTH, height: kMultimediaPreviewViewHeight)
    }
    
}
