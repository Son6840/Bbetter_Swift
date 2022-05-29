//
//  NewsController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/23.
//

import UIKit
import SwiftSoup
import Tabman
import Pageboy

class NewsController:  TabmanViewController{
    private var newsTab: Array<UIViewController> = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let social = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsSocial")
        
        let politics = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsPolitics")
        
        let economy = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsEconomy")
        
        let national = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsNational")
        
        let culture = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsCulture")
        
        let it = UIStoryboard.init(name:"News", bundle: nil).instantiateViewController(withIdentifier: "newsIT")
        
        newsTab.append(social)
        newsTab.append(politics)
        newsTab.append(economy)
        newsTab.append(national)
        newsTab.append(culture)
        newsTab.append(it)
        
        self.dataSource = self
        
        let tBar = TMBar.ButtonBar()
        tBar.layout.transitionStyle = .snap
        tBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 20.0)
        tBar.buttons.customize{(button) in
            button.tintColor = .gray
            button.selectedTintColor = .black
        } // 버튼 클릭시 텍스트 색상
        tBar.indicator.tintColor = .black
        tBar.layout.alignment = .centerDistributed
        tBar.layout.contentMode = .fit
        
        addBar(tBar, dataSource: self, at: .top)
    }
 
}
extension NewsController: PageboyViewControllerDataSource, TMBarDataSource{
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return newsTab.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return newsTab[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "사회")
        case 1:
            return TMBarItem(title: "정치")
        case 2:
            return TMBarItem(title: "경제")
        case 3:
            return TMBarItem(title: "국제")
        case 4:
            return TMBarItem(title: "문화")
        case 5:
            return TMBarItem(title: "IT")
            
            
        default:
            let title = "Page `(index)"
            return TMBarItem(title: title)
        }
    }
    
    
}
    




