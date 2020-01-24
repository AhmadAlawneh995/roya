//
//  ViewPagerCollectionViewCell.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/24/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class ViewPagerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showTime: UILabel!
    @IBOutlet weak var playImage: UIImageView!
    
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
