//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Chad on 2/25/17.
//  Copyright © 2017 Chad Williams. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate
{
  private struct Storyboard {
    static let ShowImageSegue = "Show Image"
  }

  
    // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Storyboard.ShowImageSegue {
      if let ivc = segue.destination.contentViewController as? ImageViewController {
        let imageName = (sender as? UIButton)?.currentTitle
        ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName) as URL?
        ivc.title = imageName
      }
    }
  }
  
  // replaces segues for splitview
  @IBAction func showImage(_ sender: UIButton) {
    if let ivc = splitViewController?.viewControllers.last?.contentViewController as? ImageViewController {
      let imageName = sender.currentTitle
      ivc.imageURL = DemoURL.NASAImageNamed(imageName: imageName) as URL?
      ivc.title = imageName
    } else {
      performSegue(withIdentifier: Storyboard.ShowImageSegue, sender: sender) // code segue for iphone (non splitview)
    }
  }

  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      splitViewController?.delegate = self
    }
  
  // using splitview delegation to display Cassini VC at launch instead of ImageView VC
  func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
    if primaryViewController.contentViewController == self {
      if let ivc = secondaryViewController.contentViewController as? ImageViewController, ivc.imageURL == nil {
        return true
      }
    }
    return false
  }
  

}


extension UIViewController {
  var contentViewController: UIViewController {
    if let navcon = self as? UINavigationController {
      return navcon.visibleViewController ?? self
    } else {
      return self
    }
  }

}
