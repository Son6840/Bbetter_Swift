//
//  CalenderViewViewController.swift
//  Bbetter_Swift
//
//  Created by 강재혁 on 2022/05/22.
//

import UIKit
import RealmSwift


class diaryItem: Object {
    @objc dynamic var item: String = ""
    @objc dynamic var date: String = ""
}


class CalenderViewViewController: UIViewController, UITextFieldDelegate {
    
    public var item: diaryItem?
    @IBOutlet var itemTextField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    var dataDate: String = ""
    var labelItem: String = ""
    
    


    
    private var data = [diaryItem]()
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        itemTextField.becomeFirstResponder()
        itemTextField.delegate = self
       
        dateLabel?.text! = self.dataDate
        itemTextField?.text! = self.labelItem
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(didTapCheckButton))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        itemTextField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func didTapCheckButton(){
        
        let text = itemTextField.text
        realm.beginWrite()
        let newItem = diaryItem()
        newItem.item = text!
        newItem.date = dataDate
        realm.add(newItem)
        try! realm.commitWrite()
        

    
    
       
        navigationController?.popToRootViewController(animated: true)
        
        
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
