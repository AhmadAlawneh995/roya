//
//  SubCategoryViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class SubCategoryViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var subCateroy:[Subcategory]?

    override func viewDidLoad() {
        super.viewDidLoad()


        // Do any additional setup after loading the view.
        
          NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "subCategoryNoti"), object: nil)
    }
    
    @objc func showSpinningWheel(_ notification: NSNotification) {
        if notification.object != nil {
            subCateroy = notification.object as? [Subcategory]
            subCateroy?.reverse()
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.semanticContentAttribute = .forceRightToLeft

            collectionView.register(SubCategoryCollectionViewCell.nib, forCellWithReuseIdentifier: SubCategoryCollectionViewCell.identifier)
            DispatchQueue.main.asyncAfter(deadline: .now()) { // Change `2.0` to the

                let indexPath = IndexPath(item: (self.subCateroy?.count ?? 0) - 1, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
                self.collectionView(self.collectionView, didSelectItemAt: indexPath)
            }
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

}
