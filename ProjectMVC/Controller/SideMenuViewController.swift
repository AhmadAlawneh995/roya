//
//  SideMenuViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var delayButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

     func removeView()  {
         self.willMove(toParent: nil)
         self.view.removeFromSuperview()
         self.removeFromParent()
     }
     
     
   func transparencyView() {
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              UIView.animate(withDuration: 0.2,delay: 0.0,options: .curveEaseIn, animations: {
                self.delayButton.backgroundColor = UIColor.white.withAlphaComponent(0.0)
              })
          }
      }
     
    @IBAction func closeSideMenuFromNavigateButton(_ sender: Any) {
        closeSideMenu()
    }
    
    func closeSideMenu(){
         UIView.animate(withDuration: 0.7, animations: {
             
            
              self.view.frame = CGRect(x: self.view.frame.size.width*2, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
         },completion: {(value: Bool) in
             self.removeView()
         })
     }
    @IBAction func closeSideMenuNav(_ sender: Any) {
        closeSideMenu()
    }
    

     @IBAction func closeSideMenu(_ sender: Any) {
         closeSideMenu()
     }


    @IBAction func homePressed(_ sender: Any) {
        
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSelected"), object: 4, userInfo: nil)
        closeSideMenu()

    }
    
    @IBAction func programPressed(_ sender: Any) {
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: "showSelected"), object: 3, userInfo: nil)
        closeSideMenu()

    }
    
    @IBAction func aboutUsPressed(_ sender: Any) {
        closeSideMenu()

    }
    @IBAction func programesHoures(_ sender: Any) {
        closeSideMenu()

    }
    
}
