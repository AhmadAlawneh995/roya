//
//  CategorysTableViewCell.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class CategorysTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var nib:UINib {
         return UINib(nibName: identifier, bundle: nil)
     }
     
     static var identifier: String {
         return String(describing: self)
     }
    
}
