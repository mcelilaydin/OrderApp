//
//  BaseVC.swift
//  OrderApp
//
//  Created by Celil Aydın on 8.01.2023.
//

import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("lifeCycleInfo viewDidAppear - \(Self.className)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("lifeCycleInfo viewDidAppear - \(Self.className)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("lifeCycleInfo viewDidDisappear - \(Self.className)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("lifeCycleInfo viewWillDisappear - \(Self.className)")
    }

}
