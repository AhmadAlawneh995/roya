//
//  ViewController.swift
//  RoyaTV MVVM
//
//  Created by Ahmad Alawneh on 1/9/20.
//  Copyright © 2020 Ahmad Alawneh. All rights reserved.
//

import UIKit
import FSPagerView
 
class ViewController: UIViewController {

    // MARK: definition of ui outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var pagerView: FSPagerView!
    @IBOutlet weak var barLogo: UIBarButtonItem!
    
    // MARK: definition of variables to use
    private var lastContentOffset: CGFloat = 0
    var homePreviousNowElements:HomeModel?
    var homeNewsModel:HomeNewsModel?
    var articleMain:MainArticleModel?
    var articles:Articles?


    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // MARK: add image to nav bar
           let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
           imageView.image = UIImage(named: "logo")
           let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
           buttonView.addSubview(imageView)
            barLogo.customView = buttonView

        showLoader()
        getData()
        
    }
    
    // MARK: setup side menu to show when click
    @IBAction func showSideMenu(_ sender: Any) {
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
      
    }
    
    // MARK: setup pager to handle top news
    func setUpPager()  {
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.isInfinite = true
        pagerView.automaticSlidingInterval = 3.0
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CategorysTableViewCell.nib, forCellReuseIdentifier: CategorysTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false

    }
    
    // MARK: get data from API
    func getData()  {
        let endPoint = RequestHandler.get( url: ApiURLs.home)
        

        
        APIHandler.requestString(endpoint: endPoint) { [weak self](response: Response<String>) in
           guard let strongSelf = self else {return}
            DispatchQueue.main.async {

                
            switch response.result {
                
            case .success(let value):
                

               do{
                    if let json = value.data(using: String.Encoding.utf8){
                        if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                            
                            /*
                            there was a type mismatch for the data when i received
                            it so i handle it by break each value and decode it
                            to each model
                            */
                            var homepage_elements = jsonData["homepage_elements"] as? Array<[String:Any]>
                            let mainArticle = jsonData["mainArticle"] as? [String:Any]
                            let articles = jsonData["articles"] as? Array<[String:Any]>
                            
                            
                            /*
                             Decode JSON Data
                             and refresh ui
                           */
                          if let theJSONData = try? JSONSerialization.data(
                                withJSONObject: mainArticle!,
                                options: []) {
                                let theJSONText = String(data: theJSONData,
                                                         encoding: .utf8)
                            let data = theJSONText?.data(using: .utf8)!
                            do {
                                strongSelf.articleMain = try JSONDecoder().decode(MainArticleModel.self, from: data!)
                            } catch { print(error) }
                                print("JSON string = \(theJSONText!)")
                            }

                            
                            let jsonData = try JSONSerialization.data(withJSONObject: homepage_elements![0], options: JSONSerialization.WritingOptions.prettyPrinted)

                            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                                  print(JSONString)
                                 let data = JSONString.data(using: .utf8)
                                do {
                                    strongSelf.homePreviousNowElements = try JSONDecoder().decode(HomeModel.self, from: data!)
                                 } catch {
                                 print(error)
                                    
                                }
                               }
                            
                            homepage_elements?.remove(at: 0)
                            let HomeNewsjsonData = try JSONSerialization.data(withJSONObject: homepage_elements!, options: JSONSerialization.WritingOptions.prettyPrinted)

                      if let HomeNewsJSONString = String(data: HomeNewsjsonData, encoding: String.Encoding.utf8) {
                                print(HomeNewsJSONString)
                          let data = HomeNewsJSONString.data(using: .utf8)
                          do {
                              strongSelf.homeNewsModel = try JSONDecoder().decode(HomeNewsModel.self, from: data!)
                                } catch {
                               print(error)
                     }
                }
                            
                
                            let articlasjsonData = try JSONSerialization.data(withJSONObject: articles!, options: JSONSerialization.WritingOptions.prettyPrinted)

                                        if let articalsJSONString = String(data: articlasjsonData, encoding: String.Encoding.utf8) {
                                                  print(articalsJSONString)
                                            let data = articalsJSONString.data(using: .utf8)
                                            do {
                                                strongSelf.articles = try JSONDecoder().decode(Articles.self, from: data!)
                                                strongSelf.setUpPager()
                                                strongSelf.pagerView.reloadData()
                                                strongSelf.tableView.reloadData()
                                                strongSelf.dismiss()


                                                  } catch {
                                                 print(error)
                                       }
                                  }
                            
                         
                            


                        }
                    }

                }catch {
                    print(error.localizedDescription)

                }
                    return
            case .failure(let error):
                                  print(error.localizedDescription)

                }
            }
        }
    }
    

    
 
}









