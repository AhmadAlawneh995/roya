//
//  programsExtentions.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import UIKit

// MARK: handle data to fill the view 

extension ProgramsViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return  programs?.category?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramsCollectionViewCell.identifier, for: indexPath) as! ProgramsCollectionViewCell

        cell.programTitle.text = programs?.category?[indexPath.row].name
        
        cell.selectedCellView.isHidden = true
        
        return cell
        
        
    }
    // MARK: handle selected item to show data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     
         let indexPaths = collectionView.indexPathsForVisibleItems

        for indexP in indexPaths{
            if indexP != indexPath{
          let cell = collectionView.cellForItem(at: indexP) as! ProgramsCollectionViewCell
                cell.selectedCellView.isHidden = true

            }else{
                let cell = collectionView.cellForItem(at: indexP) as! ProgramsCollectionViewCell
                cell.selectedCellView.isHidden = false

            }

            let categoryID:[String:Any] = ["categoryID":programs?.category?[indexPath.row].categoryID! ?? ""]
            if programs?.category?[indexPath.row].categoryID == 2 {
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: programs?.category?[indexPath.row].subcategory, userInfo: categoryID)
            }else{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationName"), object: programs?.category?[indexPath.row].programs, userInfo: categoryID)
            }

        }
        

        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgramsCollectionViewCell.identifier, for: indexPath) as! ProgramsCollectionViewCell

      let name = programs?.category?[indexPath.row].name
        let size = (name! as NSString).size(withAttributes: [NSAttributedString.Key.font: cell.programTitle.font!])
        return CGSize(width:size.width*1.5, height: 30)
     }
    
    
}
