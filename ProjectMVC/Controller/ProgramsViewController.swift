//
//  ProgramsViewController.swift
//  ProjectMVC
//
//  Created by Ahmad Alawneh on 1/10/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit
protocol ContainerToMaster {
    func passPrograms(program:[Program])
}


class ProgramsViewController: UIViewController {
    // MARK: definition of ui outlets
    @IBOutlet weak var barLogo: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: definition of variables to use

    var containerToMaster:ContainerToMaster?
    var programs:ProgramModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: add image to nav bar
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: "logo")
        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        buttonView.addSubview(imageView)
        barLogo.customView = buttonView
        
        

    
    }
    
    override func viewWillAppear(_ animated: Bool) {
         let nav =  self.navigationController?.navigationBar
          nav?.barStyle = UIBarStyle.black
             nav?.tintColor = UIColor.white
          nav?.topItem?.title = "البرامج"
          nav?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        showLoader()
        getData()
      }
    
    // MARK: setup collection
    func setUpcollectionViews()  {
        programs?.category?.reverse()
     
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.semanticContentAttribute = .forceRightToLeft

        collectionView.register(ProgramsCollectionViewCell.nib, forCellWithReuseIdentifier: ProgramsCollectionViewCell.identifier)
    }
    
  
   
    
    // MARK: setup sidemenu
    @IBAction func showSideMenuNav(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     if let sideMenu = storyboard.instantiateViewController(withIdentifier: "SideMenuViewControllerID") as? SideMenuViewController {
                         sideMenu.loadView()
                         let finalFrame = sideMenu.view.frame
                       
                         sideMenu.view.frame = CGRect(x: UIScreen.main.bounds.size.height/2, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
                         
                         UIView.animate(withDuration: 0.4, animations: {
                             let window:UIWindow?
                                                      if #available(iOS 13.0, *) {
                                                           window = UIApplication.shared.connectedScenes
                                                              .filter({$0.activationState == .foregroundActive})
                                                              .map({$0 as? UIWindowScene})
                                                              .compactMap({$0})
                                                              .first?.windows
                                                              .filter({$0.isKeyWindow}).first
                                                      } else {
                                                          // Fallback on earlier versions
                                                           window = UIApplication.shared.keyWindow!

                                                      }
                             sideMenu.willMove(toParent: self)
                             window?.addSubview(sideMenu.view)
                             self.addChild(sideMenu)
                             sideMenu.view.frame = finalFrame
                             sideMenu.didMove(toParent: self)
                             sideMenu.transparencyView()
                         })
                     }
           
    }
    
    // MARK: get data from API
    func getData(){
        
        let endPoint = RequestHandler.get( url: ApiURLs.programs)
           APIHandler.request(endpoint: endPoint) { [weak self](response: Response<ProgramModel>) in
              guard let strongSelf = self else {return}
               DispatchQueue.main.async {

                   
               switch response.result {
                   
               case .success(let value):
                   
                   strongSelf.programs = value
                   strongSelf.setUpcollectionViews()
                   strongSelf.dismiss()
                //  let indexPath = IndexPath(item: 0, section: 0)
                
                   DispatchQueue.main.asyncAfter(deadline: .now()) { // Change `2.0` to the
//                    strongSelf.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                    let indexPath = IndexPath(item: (strongSelf.programs?.category?.count ?? 0) - 1, section: 0)
                            strongSelf.collectionView.scrollToItem(at: indexPath, at: [.centeredVertically, .centeredHorizontally], animated: true)
                    strongSelf.collectionView(strongSelf.collectionView, didSelectItemAt: indexPath)
                   }
              
                       return
               case .failure(let error):
                                     print(error.localizedDescription)

                   }
               }
           }
    }
  

}
