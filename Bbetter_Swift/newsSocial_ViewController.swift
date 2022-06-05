//
//  newsSocial_ViewController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/29.
//

import UIKit
import SwiftSoup
import SafariServices

class newsSocial_ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var newsTitle:Elements!
    private var newsTime: Elements!
    
    
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
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! News_TableViewCell
               // let target = newsTitle[indexPath.row]
                 
                do{
                     var hangulwordPriority: NSParagraphStyle.LineBreakStrategy
                    
                    cell.socTitle.lineBreakStrategy = .hangulWordPriority
                    cell.socTitle?.text = try "\(newsTitle[indexPath.row].text())"
                    cell.socTime?.text = try "\(newsTime[indexPath.row].text())"
                }catch{}
                return cell
                
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do{
            let url = try newsTitle[indexPath.row].select("a").attr("href")
            
            UIApplication.shared.open(URL(string : url)! , options: [:])
        }
        catch{
            
        }
    }

    func crawl(){
            
                let url = URL(string: "https://news.daum.net/society#1")
              
                guard let myURL = url else {   return    }
                
                do {
                    let html = try String(contentsOf: myURL, encoding: .utf8)
                    let doc: Document = try SwiftSoup.parse(html)
                    let headerTitle = try doc.title()
                    print(headerTitle)
                    
                    newsTitle = try doc.select(".box_news_major").select(".link_txt") //.은 클래스
                    newsTime = try doc.select(".box_news_major").select(".info_cp") //.은 클래스
                    
            
                    
                    
                } catch Exception.Error(let type, let message) {
                    print("Message: \(message)")
                } catch {
                    print("error")
                }
        }


}
