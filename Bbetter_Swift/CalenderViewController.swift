//
//  CalenderViewController.swift
//  Bbetter_Swift
//
//  Created by 강재혁 on 2022/05/22.
//

import UIKit
import RealmSwift



class CalenderViewController: UIViewController {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date = dateFormatter.string(from: Date())
    
    
    private let realm = try! Realm()
 
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            itemLabel?.text! = "\(item2.item)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            itemLabel?.text! = "\(item2.item)"
        }
        
        print(type(of: date))
       print(date)
//        let list2 = realm.objects(diaryItem.self).filter("date == date")
        
       
    //    itemLabel.text = realm.objects(diaryItem.self).filter("date == 2022-05-22 10:49:09 +0000")
      //  let a = realm.objects(diaryItem.self).filter("item == 'hi'")
       // print(a)
       // var parseItem = String()
       // parseItem += "\(a)"
 //       itemLabel.text = "\(a.item)"
        
       
        
        
        
//        let list = realm.objects(diaryItem.self).filter("date == 'hi'")
//        let list2 = realm.objects(diaryItem.self)
//        print(list2)
//        if list.count == 0{
//            itemLabel?.text = ""
//        }
//        for item2 in list{
//            itemLabel?.text! += "\(item2.date)"
//        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(CalenderViewController.tapItemLabel))
        itemLabel.isUserInteractionEnabled = true
        itemLabel.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func tapItemLabel(sender:UITapGestureRecognizer){
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? CalenderViewViewController else{
            return
        }
        vc.dataDate = date
     
        
//        vc.date = self.date ?? ""
        
    
        vc.navigationItem.largeTitleDisplayMode = .never
      
        navigationController?.pushViewController(vc, animated: true)
        
     
        
        }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
       
        self.date = Self.dateFormatter.string(from: datePicker!.date)
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        
        if list.count == 0{
            itemLabel?.text! = "내용을 입력해주세요"
//            realm.beginWrite()
//            let newItem = diaryItem()
//            newItem.date = date
//            realm.add(newItem)
//
//            try! realm.commitWrite()
        }else{
            for item2 in list{
                itemLabel?.text! = "\(item2.item)"
            }
        }

        print(list)

       

      
        print(type(of: date))
        print(date)
    }
    func refresh(){
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            itemLabel?.text! = "\(item2.item)"
        }
    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


