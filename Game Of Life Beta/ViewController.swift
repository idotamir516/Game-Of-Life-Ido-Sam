//
//  ViewController.swift
//  Game Of Life Beta
//
//  Created by Ido Tamir on 11/7/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var colonyTable: UITableView!;
    @IBOutlet weak var colonyGrid: UICollectionView!;
    @IBOutlet weak var colonyOptions: UIView!;
    var colonies: [Colony];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

