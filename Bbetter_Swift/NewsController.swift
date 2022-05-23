//
//  NewsController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/23.
//

import UIKit
import SwiftSoup

class NewsController: UIViewController {

    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlAddress = "https://news.naver.com/main/main.naver?mode=LSD&mid=shm&sid1=100"
        guard let url = URL(string: urlAddress) else { return }
        
        do{
            let html = try String(contentsOf: url, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            let title: Elements = try doc.select(".content").select("h3")
        }
            catch {
        }
       
     
   
    }
}

