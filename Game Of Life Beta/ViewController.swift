//
//  ViewController.swift
//  Game Of Life Beta
//
//  Created by Ido Tamir on 11/7/16.
//  Copyright © 2016 Ido Tamir. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var colonyTable: UITableView!;
    @IBOutlet weak var colonyGrid: ColonyView!;
    @IBOutlet weak var evolveStack: UIStackView!
    @IBOutlet weak var evolveSwitch: UISwitch!
    @IBOutlet weak var evolveSlider: UISlider!
    @IBOutlet weak var stackGridAndOptions: UIStackView!
    var colonies: [Colony]!;
    var dragAlive: Bool = false;
    var currentColonyIndex: Int = 0;
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        let indexPath = NSIndexPath(row: 0, section: 0)
        //Insert this new row into the table
        
        colonyTable.insertRows(at: [indexPath as IndexPath], with: .automatic)
        colonyTable.reloadData()
        colonyGrid.setNeedsDisplay()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colony = Colony(dimensions: 10);
        colony.setCellAlive(1, yCoor: 1)
        colony.setCellAlive(30, yCoor: 30)
        colony.setCellAlive(31, yCoor: 31)
        colony.setCellAlive(32, yCoor: 30)
        colonies.append(colony);
        let colonyData = ColonyDataSource(colony: colony);
        colonyGrid.colonyData = colonyData;
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(colonies.count)
        return colonies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("got here")
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubtitleCell")
        print(cell)
        let item = colonies[indexPath.row]
        cell?.textLabel?.text = item.name ?? "Unamed colony"
        cell?.detailTextLabel?.text = item.details;
        return cell!
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        colonyTable.setEditing(editing, animated: animated)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch =  touches.first{
            print("touch began")
            let colony = colonies[currentColonyIndex];
            let (x, y) = getTouchLocation(touch: touch)
            dragAlive = !colony.isCellAlive(x, yCoor: y);
            handleTouch(xCoor: x, yCoor: y);
            print(getTouchLocation(touch: touch))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("touch moved");
        for touch in touches {
            let (x, y) = getTouchLocation(touch: touch)
            handleTouch(xCoor: x, yCoor: y)
        }
        
    }
    
    func getTouchLocation(touch: UITouch) -> (Int, Int){
        let l = touch.location(in: colonyGrid);
        let colony = colonies[currentColonyIndex];
        let unitWidth: Double = Double(colonyGrid.frame.width) / Double(colony.width);
        let unitHeight: Double = Double(colonyGrid.frame.height) / Double(colony.height);
        let x = screenToColonyX(xCoor: Double(l.x), minX: colony.xMin, unitWidth: unitWidth)
        let y = screenToColonyY(yCoor: Double(l.y), minY: colony.yMin, unitHeight: unitHeight, screenHeight: Double(colonyGrid.frame.height))
        
        return (x, y);
    }
    
    func handleTouch(xCoor x: Int, yCoor y: Int){
        let colony = colonies[currentColonyIndex];
        colony.setCell(alive: dragAlive, xCoor: x, yCoor: y);
        colonyGrid.colonyData = ColonyDataSource(colony: colony);
        colonyGrid.setNeedsDisplay()
    }
    
    func evolve(){
        colonies[currentColonyIndex].evolve();
        colonyGrid.setNeedsDisplay()
    }
    
    @IBAction func evolveStateChanged(_ sender: UISwitch) {
        if sender.isOn{
            createTimer();
            runTimer();
        }
        else{
            timer.invalidate();
        }
    }
    
    @IBAction func evolveTimeChanged(_ sender: UISlider) {
        timer.invalidate()
        createTimer();
        runTimer();
    }
    
    func createTimer(){
        
        timer = Timer(timeInterval: TimeInterval(evolveSlider.value), target: self, selector: #selector(ViewController.evolve), userInfo: nil, repeats: true)
    }
    
    func runTimer(){
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    

}

