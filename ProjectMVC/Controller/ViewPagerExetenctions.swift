//
//  ViewPagerExetenctions.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import UIKit


extension TopViewPagerViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    

     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
         return  4
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ViewPagerCollectionViewCell.identifier, for: indexPath) as! ViewPagerCollectionViewCell
        
        
        if indexPath.row == 0 {
          cell.imageView.kf.setImage(with: URL(string: homePreviousNowElements?.items?.previous?.programs?.imageURL ?? ""))
                    cell.playImage.isHidden = true
                    cell.showTitle.text = homePreviousNowElements?.items?.previous?.programs?.name
                    cell.showTime.text = "السابق"
        }
        else if indexPath.row == 1
        {
              cell.imageView.kf.setImage(with: URL(string: homePreviousNowElements?.items?.now?.programs?.imageURL ?? ""))
            cell.playImage.isHidden = false
            cell.showTitle.text = homePreviousNowElements?.items?.now?.programs?.name
            cell.showTime.text = "يعرض الآن"

        }
        else if indexPath.row == 2
               {
                   cell.imageView.kf.setImage(with: URL(string: homePreviousNowElements?.items?.next?.programs?.imageURL ?? ""))
                                      cell.playImage.isHidden = true
                                      cell.showTitle.text = homePreviousNowElements?.items?.next?.programs?.name
                cell.showTime.text = "التالي"
               }
        else if indexPath.row == 3
               {
                   cell.imageView.kf.setImage(with: URL(string: homePreviousNowElements?.items?.later?.programs?.imageURL ?? ""))
                                      cell.playImage.isHidden = true
                                      cell.showTitle.text = homePreviousNowElements?.items?.later?.programs?.name
                                      cell.showTime.text = "لاحقا"
               }
        
        
        return cell
    }
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
   
    return CGSize(width: collectionView.frame.size.width, height: 200)
  }
//    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        collectionView.scrollToItem(at: context.nextFocusedIndexPath!, at: .centeredHorizontally, animated: true)
//    }

    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        self.collectionView.scrollToNearestVisibleCollectionViewCell()
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            self.collectionView.scrollToNearestVisibleCollectionViewCell()
//        }
//    }

    
}

extension UICollectionView {
    func scrollToNearestVisibleCollectionViewCell() {
        self.decelerationRate = UIScrollView.DecelerationRate.fast
        let visibleCenterPositionOfScrollView = Float(self.contentOffset.x + (self.bounds.size.width / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        for i in 0..<self.visibleCells.count {
            let cell = self.visibleCells[i]
            let cellWidth = cell.bounds.size.width
            let cellCenter = Float(cell.frame.origin.x + cellWidth / 2)

            // Now calculate closest cell
            let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
            if distance < closestDistance {
                closestDistance = distance
                closestCellIndex = self.indexPath(for: cell)!.row
            }
        }
        if closestCellIndex != -1 {
            self.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}


extension TopViewPagerViewController: UIScrollViewDelegate {
    
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToCenter()
            
    }
    
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            if scrollView.panGestureRecognizer.translation(in: scrollView.superview).x > 0 {
               print("left")
                if elementsCounts < 3 {
                    elementsCounts = elementsCounts + 1
                    
                }
            } else {
                if elementsCounts != 0{
                      elementsCounts = elementsCounts - 1
                }
               print("right")
            }
        if !decelerate {
            snapToCenter()
        }
    }

    
}
