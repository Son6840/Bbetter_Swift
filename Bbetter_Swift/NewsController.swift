//
//  NewsController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/23.
//

import UIKit
import SwiftSoup

class NewsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    private var newsTitle:Elements!
    
    @IBOutlet weak var table: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.delegate = self
        self.table.dataSource = self
        crawl()
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        let target = newsTitle[indexPath.row]
         
        do{
        cell.textLabel?.text = try "\(newsTitle[indexPath.row].text())"
        }catch{}
        return cell
        
    }
    
    
    func crawl(){
        
            let url = URL(string: "https://news.daum.net")
          
            guard let myURL = url else {   return    }
            
            do {
                let html = try String(contentsOf: myURL, encoding: .utf8)
                let doc: Document = try SwiftSoup.parse(html)
                let headerTitle = try doc.title()
                print(headerTitle)
                
                newsTitle = try doc.select(".tit_g").select(".link_txt") //.은 클래스
                for i in newsTitle {
                    print("title: ", try i.text())
                    
                }
                
                
                
            } catch Exception.Error(let type, let message) {
                print("Message: \(message)")
            } catch {
                print("error")
            }
    }
}

