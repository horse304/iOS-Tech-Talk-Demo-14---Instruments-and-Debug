//
//  Demo.swift
//  TekTalkDemo
//
//  Created by Nguyen Dat on 12/26/15.
//  Copyright © 2015 Atlassian. All rights reserved.
//

import UIKit

struct Demo {
    static func smallImages() -> [SmartImageSource] {
        var images = [SmartImageSource]()
        if let imageUrls = getFilesInFolder("SmallImages") {
            for url in imageUrls {
                let data = NSData(contentsOfURL: url)
                if let image = data.flatMap({ UIImage(data: $0) }) {
                    images.append(SmartImageSource.Image(image))
                }
            }
        }
        
        return images
    }
    
    static func largeImages() -> [SmartImageSource] {
        var images = [SmartImageSource]()
        if let imageUrls = getFilesInFolder("LargeImages") {
            for url in imageUrls {
                let data = NSData(contentsOfURL: url)
                if let image = data.flatMap({ UIImage(data: $0) }) {
                    images.append(SmartImageSource.Image(image))
                }
            }
        }
        
        return images
    }
    
    static func flickrUrls() -> [SmartImageSource] {
        return [
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/542/19074222720_ca5640fc18_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/484/19842262825_2ecda54469_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm4.staticflickr.com/3780/19746597276_333687c75b_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/527/19443722469_6dd25e511f_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/742/22592907411_dc7d5fea8c_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm6.staticflickr.com/5733/21370008480_951e8b0d41_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm6.staticflickr.com/5639/22882457654_b57eae1e89_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm5.staticflickr.com/4049/4549935568_e2db899404_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/710/23584867345_47388f8e91_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/616/23477209521_3daf88c955_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/542/19074222720_ca5640fc18_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/484/19842262825_2ecda54469_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm4.staticflickr.com/3780/19746597276_333687c75b_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/527/19443722469_6dd25e511f_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/742/22592907411_dc7d5fea8c_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm6.staticflickr.com/5733/21370008480_951e8b0d41_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm6.staticflickr.com/5639/22882457654_b57eae1e89_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm5.staticflickr.com/4049/4549935568_e2db899404_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/710/23584867345_47388f8e91_b.jpg")!),
            SmartImageSource.Url(NSURL(string: "https://farm1.staticflickr.com/616/23477209521_3daf88c955_b.jpg")!),
            
        ]
    }
    
    
    static func smallImageUrls() -> [SmartImageSource] {
        var images = [SmartImageSource]()
        if let imageUrls = getFilesInFolder("SmallImages") {
            for url in imageUrls {
                images.append(SmartImageSource.Url(url))
            }
        }
        
        return images
    }
    
    static func largeImageUrls() -> [SmartImageSource] {
        var images = [SmartImageSource]()
        if let imageUrls = getFilesInFolder("LargeImages") {
            for url in imageUrls {
                images.append(SmartImageSource.Url(url))
            }
        }
        
        return images
    }
    
    static func getFilesInFolder(name: String) -> [NSURL]? {
        let folderUrl = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent(name)
        let fileUrls = try? NSFileManager.defaultManager().contentsOfDirectoryAtURL(folderUrl, includingPropertiesForKeys: nil, options: .SkipsSubdirectoryDescendants)
        
        return fileUrls
    }
}
