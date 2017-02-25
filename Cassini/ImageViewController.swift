//
//  ImageViewController.swift
//  Cassini
//
//  Created by Chad on 2/24/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
  
  var imageURL: NSURL? {
    didSet {
      image = nil
      fetchImage()
    }
  }
  
  fileprivate func fetchImage() {
    if let url = imageURL {
      if let imageData = NSData(contentsOf: url as URL) {
        image = UIImage(data: imageData as Data)
      }
    }
  }
  
  @IBOutlet weak var scrollView: UIScrollView! {
    didSet {
      scrollView.contentSize = imageView.frame.size
      scrollView.delegate = self
      scrollView.minimumZoomScale = 0.03
      scrollView.maximumZoomScale = 1.0
    }
  }
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return imageView
  }
  
  
  fileprivate var imageView = UIImageView()
  
  fileprivate var image: UIImage? {
    set {
      imageView.image = newValue
      imageView.sizeToFit()
      scrollView?.contentSize = imageView.frame.size
    }
    get {
      return imageView.image
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.addSubview(imageView)
  }



}
