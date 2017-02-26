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
      if view.window != nil { // if view is on screen
        fetchImage()
      }
    }
  }
  
  fileprivate func fetchImage() {
    if let url = imageURL {
      spinner?.startAnimating()
      
      DispatchQueue.global(qos: .userInitiated).async {
        let contentsOfURL = NSData(contentsOf: url as URL)
        
        DispatchQueue.main.async {
          if url == self.imageURL {
            if let imageData = contentsOfURL {
              self.image = UIImage(data: imageData as Data)
            } else {
              self.spinner?.stopAnimating()
            }
          } else {
            print("ignored data returned from url \(url)")
          }
        }
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
  
  
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  fileprivate var image: UIImage? {
    set {
      imageView.image = newValue
      imageView.sizeToFit()
      scrollView?.contentSize = imageView.frame.size
      spinner?.stopAnimating()
    }
    get {
      return imageView.image
    }
  }
  

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if image == nil {
      fetchImage()
    }
  }
  
  

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.addSubview(imageView)
  }



}
