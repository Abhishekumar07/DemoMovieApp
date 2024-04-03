//
//  FilterPopupViewController.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

import UIKit

class FilterPopupViewController: UIViewController {
    
    @IBOutlet var selectFirstOptoin: UIButton!
    @IBOutlet var selectSecondOptoin: UIButton!
    var navigation : UINavigationController?
    var completionHandler: ((String) -> Void)?
    var containValueOfButton = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if containValueOfButton == 1 {
            containValueOfButton = 1
            selectFirstOptoin.isSelected = true
            selectFirstOptoin.setImage(UIImage(named: "selectedRadioButton"), for: .normal)
            selectSecondOptoin.isSelected = false
            selectSecondOptoin.setImage(UIImage(named: "circle"), for: .normal)
            
        }else if containValueOfButton == 2 {
            containValueOfButton = 2
            selectFirstOptoin.isSelected = false
            selectFirstOptoin.setImage(UIImage(named: "circle"), for: .normal)
            selectSecondOptoin.isSelected = true
            selectSecondOptoin.setImage(UIImage(named: "selectedRadioButton"), for: .normal)
            
        }else{
            print("not select")
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func radioButtonSelect(_ sender: UIButton) {
        if (sender as AnyObject).tag == 1 {
            containValueOfButton = 1
            selectFirstOptoin.isSelected = true
            selectFirstOptoin.setImage(UIImage(named: "selectedRadioButton"), for: .normal)
            selectSecondOptoin.isSelected = false
            selectSecondOptoin.setImage(UIImage(named: "circle"), for: .normal)
            
        }else if sender.tag == 2 {
            containValueOfButton = 2
            selectFirstOptoin.isSelected = false
            selectFirstOptoin.setImage(UIImage(named: "circle"), for: .normal)
            selectSecondOptoin.isSelected = true
            selectSecondOptoin.setImage(UIImage(named: "selectedRadioButton"), for: .normal)
            
        }
    }

    @IBAction func screenTouchCancelButton(_ sender: Any) {
        self.dismiss(animated: false)
    }
    
    @IBAction func showResultButton(_ sender: Any) {
        if containValueOfButton == 1 {
            sendValueBackTitle()
        }else if containValueOfButton == 2 {
            sendValueBackForReleaseDate()
        }else{
            self.showToast(message: "Please select option for filter", font: .systemFont(ofSize: 14.0))
        }
        
    }
    
    func sendValueBackTitle() {
        completionHandler?("Title")
        self.dismiss(animated: false, completion: nil)
    }
    
    func sendValueBackForReleaseDate() {
        completionHandler?("ReleaseDate")
        self.dismiss(animated: false, completion: nil)
    }
}
