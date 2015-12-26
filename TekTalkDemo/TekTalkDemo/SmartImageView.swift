//
//  SmartImageView.swift
//  TekTalkDemo
//
//  Created by Nguyen Dat on 12/26/15.
//  Copyright © 2015 Atlassian. All rights reserved.
//

import UIKit

enum SmartImageSource {
    case ImageName(String)
    case Image(UIImage)
    case Url(NSURL)
    
    func getImage() -> UIImage? {
        let image:UIImage?
        switch self {
        case .Image(let imageObject):
            image = imageObject
        case .ImageName(let name):
            image = UIImage(named: name)
        case .Url(let url):
            let data = NSData(contentsOfURL: url)
            image = data.flatMap{ UIImage(data: $0) }
        }
        
        return image
    }
    
    func getImageAsync(onFinished:(image: UIImage?) -> Void) -> NSOperation {
        let block = NSBlockOperation()
        block.addExecutionBlock {[weak block] () -> Void in
            guard let weakBlock = block else { return }
            if !weakBlock.cancelled {
                let image = self.getImage()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if !weakBlock.cancelled {
                        onFinished(image: image)
                    }
                })
            }
        }
        
        return block
    }
}

extension SmartImageSource: Hashable {
    var hashValue: Int {
        let uniqueString: String
        switch self {
        case .ImageName(let name):
            uniqueString = "ImageName \(name.hashValue)"
        case .Image(let image):
            uniqueString = "Image \(image.hashValue)"
        case .Url(let url):
            uniqueString = "Url \(url.hashValue)"
        }
        
        return uniqueString.hashValue
    }
}
func ==(lhs: SmartImageSource, rhs: SmartImageSource) -> Bool {
    return lhs.hashValue == rhs.hashValue
}

class SmartImageView: UIImageView {
    private static var cachedImages = [SmartImageSource: UIImage]()
    private static var queueLoadImages: NSOperationQueue = {
        let queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()

    private var currentLoadOperation: NSOperation?
    var enabledCached: Bool = false
    var enabledAsync: Bool = false
    var enabledResizeImage: Bool = false
    
    var imageSource: SmartImageSource? {
        didSet {
            currentLoadOperation?.cancel()

            guard let imageSource = imageSource else {
                image = nil
                return
            }
            
            if let cached = SmartImageView.cachedImages[imageSource] where enabledCached {
                print("Loaded image from cached")
                image = cached
            } else {
                startGetImage(imageSource)
            }
        }
    }
    
    private func startGetImage(imageSource: SmartImageSource) {
        if enabledAsync {
            print("Start get image from SmartImageSource -- Async")
            //Load image asynchronously
            currentLoadOperation = imageSource.getImageAsync({[weak self] (image) -> Void in
                guard let weakSelf = self else { return }
                
                weakSelf.image = weakSelf.enabledResizeImage ? image?.resizedImage() : image
                
                if let image = image where weakSelf.enabledCached {
                    SmartImageView.cachedImages[imageSource] = image
                }
            })
            SmartImageView.queueLoadImages.addOperation(currentLoadOperation!)
        } else {
            print("Start get image from SmartImageSource -- Sync")
            //Load image synchronously
            self.image = imageSource.getImage()
            self.image = self.enabledResizeImage ? image?.resizedImage() : image
            
            if let image = image where enabledCached {
                SmartImageView.cachedImages[imageSource] = image
            }
        }
    }
    
    func cancel() {
        currentLoadOperation?.cancel()
    }
    
    
    func debugQuickLookObject() -> AnyObject {
        switch imageSource {
        case .Some(.Image(let image)):
            return "Source is instance of UIImage: \(image)"
        case .Some(.ImageName(let name)):
            return "Source is image name: \(name)"
        case .Some(.Url(let url)):
            return "Source is url: \(url)"
            
        default:
            return "Don't have source"
        }
    }
}
import AVFoundation

extension UIImage {
    func resizedImage() -> UIImage? {
        if size.width/300 < 2.0 || size.height/300 < 2.0 {
            return self
        }
        
        let rect = AVMakeRectWithAspectRatioInsideRect(size, CGRect(origin: CGPointZero, size: CGSize(width: 300,height: 300)))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.mainScreen().scale)
        defer {
            UIGraphicsEndImageContext()
        }
        
        drawInRect(CGRect(origin: CGPointZero, size: rect.size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let pngData = UIImagePNGRepresentation(image)
        
        return UIImage(data: pngData!)
    }
}
