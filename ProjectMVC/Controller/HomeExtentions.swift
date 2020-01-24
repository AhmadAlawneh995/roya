//
//  HomeExtentions.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import FSPagerView
import Kingfisher





// MARK: handle table view and fill up the data

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  homeNewsModel?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategorysTableViewCell.identifier) as! CategorysTableViewCell
        
        cell.categoryTitle.text = homeNewsModel?[indexPath.row].elementTitle
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.semanticContentAttribute = .forceRightToLeft

        cell.collectionView.register(GategoryCollectionViewCell.nib, forCellWithReuseIdentifier: GategoryCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()

        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

// MARK: handle collection view and fill up the data

extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
   
        return homeNewsModel?[collectionView.tag].items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GategoryCollectionViewCell.identifier, for: indexPath) as! GategoryCollectionViewCell
     
        let url = homeNewsModel?[collectionView.tag].items?[indexPath.row].imageURL
        cell.categoryImageView.kf.setImage(with: URL(string: url ?? ""))
  
        return cell
    }


    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
         let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
         let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
         return CGSize(width: size, height: size / 1.5)
     }



}

