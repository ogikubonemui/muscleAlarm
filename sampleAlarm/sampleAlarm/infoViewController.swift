//
//  infoViewController.swift
//  sampleAlarm
//
//  Created by Yasuyuki Takeshita on 12/06/2019.
//  Copyright © 2019 Yasuyuki Takeshita. All rights reserved.
//

import UIKit

class infoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func didClickBtn(_ sender: Any) {
        performSegue(withIdentifier: "toMain", sender: nil)

    }
    


}
