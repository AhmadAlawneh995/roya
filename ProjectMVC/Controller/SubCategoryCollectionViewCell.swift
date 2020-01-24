//
//  SubCategoryCollectionViewCell.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class SubCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var subCategoryTitle: UILabel!
    @IBOutlet weak var selectedSubCategory: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    static var nib:UINib {
              return UINib(nibName: identifier, bundle: nil)
          }
          
          static var identifier: String {
              return String(describing: self)
          }

}
