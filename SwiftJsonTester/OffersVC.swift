//
//  OffersVC.swift
//  SwiftJsonTester
//
//  Created by Adam Chin on 12/5/16.
//  Copyright © 2016 hushbox. All rights reserved.
//

import UIKit

class OffersVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    var items: [String] = ["Some", "Stubby", "Offer"]
    
    var receivedOffers: NSArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.layer.cornerRadius = 5
        closeButton.clipsToBounds = true
         self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.receivedOffers.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        
        let offer: NSDictionary = receivedOffers[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = offer .value(forKey: "title") as! String?
    
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("You selected cell #\(indexPath.row)!")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
