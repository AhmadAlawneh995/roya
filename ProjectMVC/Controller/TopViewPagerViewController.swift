//
//  TopViewPagerViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit
enum ScrollDirection {
    case left
    case right
}
class TopViewPagerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var homePreviousNowElements:HomeModel?
    var elementsCounts = 1
    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(ViewPagerCollectionViewCell.nib, forCellWithReuseIdentifier: ViewPagerCollectionViewCell.identifier)
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.frame = CGRect(x: 0 , y: 0, width: UIScreen.main.bounds.width, height: 200)


         NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "setupTop"), object: nil)
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
      

    }
    // MARK: handle notification
      @objc func showSpinningWheel(_ notification: NSNotification) {
             print(notification.userInfo ?? "")
        
        homePreviousNowElements = notification.object as? HomeModel
     
        if homePreviousNowElements != nil {
            let indexPath = IndexPath(item: 1, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }

          collectionView.reloadData()
         
      }
    
    @IBAction func previosPressed(_ sender: Any) {
        if elementsCounts != 0{
            elementsCounts = elementsCounts - 1
        let indexPath = IndexPath(item: elementsCounts, section: 0)
                  self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if elementsCounts < 3 {
            elementsCounts = elementsCounts + 1

            let indexPath = IndexPath(item: elementsCounts, section: 0)
                          self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func snapToCenter() {
        let centerPoint = view.convert(view.center, to: collectionView)
         let centerIndexPath = collectionView.indexPathForItem(at: centerPoint)
        collectionView.scrollToItem(at: centerIndexPath!, at: .centeredHorizontally, animated: true)
    }

}
