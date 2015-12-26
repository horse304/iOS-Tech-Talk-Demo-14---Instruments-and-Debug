//
//  ImageCellView.swift
//  TekTalkDemo
//
//  Created by Nguyen Dat on 12/25/15.
//  Copyright © 2015 Atlassian. All rights reserved.
//

import UIKit

class ImageCellView: UICollectionViewCell {
    @IBOutlet weak var imageView: SmartImageView! {
        didSet {
            imageView.enabledAsync = true
            imageView.enabledCached = true
//            imageView.enabledResizeImage = true
        }
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        layer.cornerRadius = 4.0
//        layer.shadowOpacity = 1.0
//        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//        layer.shadowColor = UIColor.blackColor().CGColor
//        
//        layer.shadowPath = UIBezierPath(rect: self.bounds).CGPath
//        layer.masksToBounds = true
//        
//        self.layer.shouldRasterize = true
//        self.layer.rasterizationScale = UIScreen.mainScreen().scale
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.imageSource = nil
    }
}
