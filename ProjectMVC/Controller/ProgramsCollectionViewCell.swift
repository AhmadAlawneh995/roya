//
//  ProgramsCollectionViewCell.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class ProgramsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var selectedCellView: UIView!
    
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
