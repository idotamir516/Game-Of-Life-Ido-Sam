//
//  ViewController.swift
//  Game Of Life Beta
//
//  Created by Ido Tamir on 11/7/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var colonyTable: UITableView!;
    @IBOutlet weak var colonyGrid: ColonyView!;
    @IBOutlet weak var colonyOptions: UIView!;
    var colonies: [Colony]!;

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colony = Colony(dimensions: 60);
        colony.setCellAlive(30, yCoor: 30)
        colony.setCellAlive(31, yCoor: 31)
        colony.setCellAlive(32, yCoor: 30)
        let colonyData = ColonyDataSource(colony: colony);
        colonyGrid.colonyData = colonyData;
        colonyTable.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colonies.count
    }
    
}

