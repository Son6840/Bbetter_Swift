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

        let tap = UITapGestureRecognizer(target: self, action: #selector(CalenderViewController.tapItemLabel))
        itemLabel.isUserInteractionEnabled = true
        itemLabel.addGestureRecognizer(tap)

    }
    
    @objc func tapItemLabel(sender:UITapGestureRecognizer){
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? CalenderViewViewController else{
            return
        }
        vc.dataDate = date
        vc.navigationItem.largeTitleDisplayMode = .never
      
        navigationController?.pushViewController(vc, animated: true)
        
     
        
        }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
       
        self.date = Self.dateFormatter.string(from: datePicker!.date)
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        
        if list.count == 0{
            itemLabel?.text! = "내용을 입력해주세요"
        }else{
            for item2 in list{
                itemLabel?.text! = "\(item2.item)"
            }
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


