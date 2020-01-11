//
//  LiveViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit

class LiveViewController: UIViewController {
    @IBOutlet weak var barLogo: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: add logo to nav bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "logo")
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        buttonView.addSubview(imageView)
        barLogo.customView = buttonView
    }
    

    // MARK: setup side menu

    @IBAction func showSideMenuNav(_ sender: Any) {
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
                             //let window = UIApplication.shared.keyWindow!
                             sideMenu.willMove(toParent: self)
                             window?.addSubview(sideMenu.view)
                             self.addChild(sideMenu)
                             sideMenu.view.frame = finalFrame
                             sideMenu.didMove(toParent: self)
                             sideMenu.transparencyView()
                         })
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
