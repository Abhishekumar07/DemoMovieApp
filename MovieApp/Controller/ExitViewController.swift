//
//  ExitViewController.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

import UIKit

class ExitViewController: UIViewController {

    @IBOutlet weak var countAppOpen: UILabel!
    var number = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.integer(forKey: "number") == 0 {
            number = 1
            countAppOpen.text = "1"
        }else {
            number = UserDefaults.standard.integer(forKey: "number")
            countAppOpen.text =
            "\(UserDefaults.standard.integer(forKey: "number"))"
        }
        // Do any additional setup after loading the view.
    }


    @IBAction func closeAppButton(_ sender: Any) {
            exit(0)
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
