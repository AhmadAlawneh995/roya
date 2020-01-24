//
//  SubCategoryViewControllerExtentions.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import UIKit


extension SubCategoryViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return  subCateroy?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryCollectionViewCell.identifier, for: indexPath) as! SubCategoryCollectionViewCell
        cell.subCategoryTitle.text = subCateroy?[indexPath.row].name
        cell.selectedSubCategory.isHidden = true
     
        return cell
    }
    
    
    // MARK: handle selected item to show data
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
          let indexPaths = collectionView.indexPathsForVisibleItems

         for indexP in indexPaths{
             if indexP != indexPath{
           let cell = collectionView.cellForItem(at: indexP) as! SubCategoryCollectionViewCell
                 cell.selectedSubCategory.isHidden = true

             }else{
                 let cell = collectionView.cellForItem(at: indexP) as! SubCategoryCollectionViewCell
                 cell.selectedSubCategory.isHidden = false

            }
            
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "selectedSubCategory"), object: subCateroy?[indexPath.row].programs, userInfo: nil)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCategoryCollectionViewCell.identifier, for: indexPath) as! SubCategoryCollectionViewCell

       let name = subCateroy?[indexPath.row].name
         let size = (name! as NSString).size(withAttributes: [NSAttributedString.Key.font: cell.subCategoryTitle.font!])
     
        return CGSize(width:size.width*1.5, height: 30)
      }
}
