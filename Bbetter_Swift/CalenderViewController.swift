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
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat){
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: itemLabel.frame.width, height: borderWidth)
        itemLabel.addSubview(border)
    }

    
    
   
    
    
    
    private let realm = try! Realm()
 
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            if "\(item2.item)" == ""{
                itemLabel?.text! = "내용을 입력해주세요"
                itemLabel.textColor = UIColor.lightGray
            }else{
            itemLabel?.text! = "\(item2.item)"
            itemLabel.textColor = UIColor.black
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            itemLabel?.text! = "\(item2.item)"
            itemLabel.textColor = UIColor.black
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(CalenderViewController.tapItemLabel))
        itemLabel.isUserInteractionEnabled = true
        itemLabel.addGestureRecognizer(tap)
        self.itemLabel.numberOfLines = 0
        addTopBorder(with: UIColor.black, andWidth: CGFloat(0.5))
//        itemLabel.layer.borderWidth = 1
      
      

    }
    
    @objc func tapItemLabel(sender:UITapGestureRecognizer){
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? CalenderViewViewController else{
            return
        }
        vc.dataDate = date
        
        if itemLabel?.text == "내용을 입력해주세요" {
            vc.labelItem = ""
        }else{
            vc.labelItem = itemLabel?.text ?? ""
        }
       
        
        vc.navigationItem.largeTitleDisplayMode = .never
      
        navigationController?.pushViewController(vc, animated: true)
        
     
        
        }
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
       
        self.date = Self.dateFormatter.string(from: datePicker!.date)
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        
        if list.count == 0{
            itemLabel?.text! = "내용을 입력해주세요"
            itemLabel.textColor = UIColor.lightGray
        }else{
           
            for item2 in list{
                if "\(item2.item)" == ""{
                    itemLabel?.text! = "내용을 입력해주세요"
                    itemLabel.textColor = UIColor.lightGray
                }else{
                itemLabel?.text! = "\(item2.item)"
                    itemLabel.textColor = UIColor.black
            }
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


