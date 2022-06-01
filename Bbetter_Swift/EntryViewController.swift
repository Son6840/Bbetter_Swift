//
//  EntryViewController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/15.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    


        @IBOutlet var textField: UITextField!
        @IBOutlet var datePicker: UIDatePicker!
        @IBOutlet var dDay: UILabel!
        
        private let realm = try! Realm()
        public var completionHandler: (() -> Void)?
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
        
        override func viewDidLoad() {
            super.viewDidLoad()

            textField.becomeFirstResponder()
            textField.delegate = self
            
            datePicker.setDate(Date(), animated: true)
            textField.placeholder = "디데이 제목을 입력하세요."
            dDay?.text! = "D-DAY"
            
           
            
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date
            
            
            let nowDate = ViewViewController.dateFormatter.string(from: Date())
            let selectDate = ViewViewController.dateFormatter.string(from: date)
            let startDate = ViewViewController.dateFormatter.date(from: "\(nowDate)")!
            let endDate = ViewViewController.dateFormatter.date(from: "\(selectDate)")
            
            let interval = (endDate?.timeIntervalSince(startDate))!
            let daya = Int((interval ) / 86400)
            var daya2 = ""
            
            if daya < 0 {
                daya2 = "D+\(daya * -1)"
            }else if daya == 0{
               daya2 = "D-DAY"
            }else{
                daya2 = "D-\(daya)"
            }
           
            print("날짜 차이는\(daya)")
            
            
            realm.beginWrite()
            let newItem = ToDoListItem()
            newItem.Dday = daya2
            newItem.date = date
            newItem.item = text
            realm.add(newItem)
            
            try! realm.commitWrite()
            
            completionHandler?()
            navigationController?.popToRootViewController(animated: true)
        }else{
            print("항목을 추가하세요")
        }
    }
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        let date = datePicker.date
        
        let nowDate = ViewViewController.dateFormatter.string(from: Date())
        let selectDate = ViewViewController.dateFormatter.string(from: date)
        let startDate = ViewViewController.dateFormatter.date(from: "\(nowDate)")!
        let endDate = ViewViewController.dateFormatter.date(from: "\(selectDate)")
        
        let interval = (endDate?.timeIntervalSince(startDate))!
        let daya = Int((interval ) / 86400)
        if daya < 0 {
           let daya2 = daya * -1
            dDay?.text! = "D+\(daya2)"
        }else if daya == 0{
            dDay?.text! = "D-DAY"
        }else{
            dDay?.text! = "D-\(daya)"
        }
       
    }

}
