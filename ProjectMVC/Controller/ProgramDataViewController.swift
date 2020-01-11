//
//  ProgramDataViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit



class ProgramDataViewController: UIViewController {
 
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var program:[Program]?
    var subCateroy:[Subcategory]?
    var categoryId = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSpinningWheel(_:)), name: NSNotification.Name(rawValue: "notificationName"), object: nil)

        setupCollectionView()
    }
    
  // MARK: handle notification
    @objc func showSpinningWheel(_ notification: NSNotification) {
           print(notification.userInfo ?? "")
      
        program = notification.object as? [Program]
        collectionView.reloadData()
       
    }
    // MARK: setup Collection view 

    func setupCollectionView(){
     

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProgramDataCollectionViewCell.nib, forCellWithReuseIdentifier: ProgramDataCollectionViewCell.identifier)
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
