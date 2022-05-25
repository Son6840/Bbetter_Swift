//
//  TranslateViewController.swift
//  Bbetter_Swift
//
//  Created by 강재혁 on 2022/05/17.
//

import UIKit

class TranslateViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet  var searchText1: UITextView!
    @IBOutlet  var textLabel1: UILabel!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchText1.delegate = self
        self.searchText1.refreshControl?.addTarget(self, action: #selector(textViewDidChange(_:)), for: .editingChanged) //실시간입력 되었을때 번역함수 호출
        self.textLabel1.numberOfLines = 0


        // Do any additional setup after loading the view.
    }
    struct Papago: Codable {
        let message: Message
    }
    struct Message: Codable {
        let result: Result
    }
    struct Result: Codable{
        let translatedText: String
        let srcLangType: String
        let tarLangType: String
    }
    
    @objc func textViewDidChange(_ textView: UITextView) {
        callURL()
    }

    func callURL(){
        let text = searchText1.text!
        let param = "source=ko&target=en&text=\(text)"
        let paramData = param.data(using: .utf8)
        let Naver_URL = URL(string: "https://openapi.naver.com/v1/papago/n2mt")
        
        let ClientID = "Hh2mfTWbBwsDiGUc9wC4"
        let ClientSecret = "VqZyDhr4Lz"
        
        var request = URLRequest(url:Naver_URL!)
        request.httpMethod = "POST"
        request.addValue(ClientID,forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(ClientSecret,forHTTPHeaderField: "X-Naver-Client-Secret")
        request.httpBody = paramData
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
        
        //Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        //Task
        let task = session.dataTask(with: request) { (data, response, error) in
            
            
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode(Papago.self, from: data!)
                    
                    print(decodedData)
                    DispatchQueue.main.async {
                        self.textLabel1.text = decodedData.message.result.translatedText
                        
                    }
                }catch{
                    print("error")
                }
            }
            //통신 실패
            if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }


}
