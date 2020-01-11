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


// MARK: handle Pager And fill up the data

extension ViewController:FSPagerViewDelegate,FSPagerViewDataSource{
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
      let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        if index == 0 {
            
            cell.imageView?.load(url: URL(string: homePreviousNowElements?.items?.now?.programs?.imageURL ?? "")!)
            cell.textLabel?.text = homePreviousNowElements?.items?.now?.programs?.name

            }
        else if index == 1{
            cell.imageView?.load(url: URL(string: homePreviousNowElements?.items?.previous?.programs?.imageURL ?? "")!)
            cell.textLabel?.text = homePreviousNowElements?.items?.previous?.programs?.name

        }

        cell.imageView?.contentMode = .scaleAspectFit

        cell.textLabel?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        return cell

    }
    
    
    
}

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
        cell.collectionView?.scrollToItem(at: NSIndexPath(item: (homeNewsModel?[indexPath.row].items!.count)! - 1, section: 0) as IndexPath, at: .right, animated: false)

        cell.collectionView.register(GategoryCollectionViewCell.nib, forCellWithReuseIdentifier: GategoryCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()

        return cell
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
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
        return CGSize(width: 250, height: 200)
       }


}

