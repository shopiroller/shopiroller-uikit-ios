//
//  ViewController.swift
//  Shopiroller
//
//  Created by ealtaca on 09/29/2021.
//  Copyright (c) 2021 ealtaca. All rights reserved.
//

import UIKit
import Shopiroller

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = SRMainPageViewController(viewModel: SRMainPageViewModel())
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

