//
//  TabBarController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = 4
        self.delegate = self
        tabBar.itemPositioning = .fill
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showSelected(_:)), name: NSNotification.Name(rawValue: "showSelected"), object: nil)
    }
    
    // MARK: handle notification
       @objc func showSelected(_ notification: NSNotification) {
              print(notification.userInfo ?? "")
        let selectedPage = notification.object as? Int
        selectedIndex = selectedPage!
          
       }
       
    //MARK:- Tab Bar Delegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is SideMenuViewController {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let sideMenu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewControllerID") as? SideMenuViewController {
                sideMenu.loadView()
                let finalFrame = sideMenu.view.frame
              
                sideMenu.view.frame = CGRect(x: UIScreen.main.bounds.size.height/2, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                
                UIView.animate(withDuration: 0.4, animations: {
                    let window = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == .foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0})
                    .first?.windows
                    .filter({$0.isKeyWindow}).first
                    sideMenu.willMove(toParent: self)
                    window?.addSubview(sideMenu.view)
                    self.addChild(sideMenu)
                    sideMenu.view.frame = finalFrame
                    sideMenu.didMove(toParent: self)
                    sideMenu.transparencyView()
                })
            }
            return false
        }else{
            return true
        }
    }
}

