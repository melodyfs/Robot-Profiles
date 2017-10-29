//
//  ViewController.swift
//  AppBundleReader
//
//  Created by Eliel A. Gordon on 10/26/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    let path = Bundle.main.url(forResource: "robo-profiles", withExtension: ".json")
    
    var robots = [Robots]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if let path = path {
            do {
                let data = try Data(contentsOf: path)
                let robot = try? JSONDecoder().decode([Robots].self, from: data)
                self.robots = robot!
                print(robot)
            } catch {
                print(error)
                
            }
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return robots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        let robot = robots[indexPath.row]
        
        cell.nameLabel.text = robot.name
        cell.personalityLabel.text = robot.personality
        cell.phraseLabel.text = robot.phrase
        
        DispatchQueue.main.async {
            
            cell.imageView?.getImageFromURL(url: robot.image)
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}



