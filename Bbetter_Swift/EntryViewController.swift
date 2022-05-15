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
        
        private let realm = try! Realm()
        public var completionHandler: (() -> Void)?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            textField.becomeFirstResponder()
            textField.delegate = self
            
            datePicker.setDate(Date(), animated: true)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapSaveButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    @objc func didTapSaveButton() {
        if let text = textField.text, !text.isEmpty {
            let date = datePicker.date
            
            realm.beginWrite()
            let newItem = ToDoListItem()
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


}
