//
//  ViewController.swift
//  TablesTurn
//
//  Created by Koray Ece on 07.06.18.
//  Copyright © 2018 Koray Ece. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    

    
    var petitions = [[String: String]]()
    var labels = [String: UILabel]()
    

    
    override func viewDidLoad() {
        
        self.tableView.backgroundColor = UIColor.lightGray
        
        
        super.viewDidLoad()
        
        
        
        
        
        let urlString = "https://api.coinmarketcap.com/v2/listings/"
        
        // https://api.coinmarketcap.com/v2/ticker/?limit=10
        // listings https://api.coinmarketcap.com/v2/listings/
        // another link
        
        if let url = URL(string: urlString) {
            
            if let data = try? String(contentsOf: url) {
                
                let json = JSON(parseJSON: data)
                
                if json["data"] != JSON.null {
                    
                    
                    print(json)
                    parse(json: json)
                    
                    
                }
            }
            
        }
        
        
        
        self.title = "CryptoCurrencys: \(petitions.count)"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func parse(json: JSON) {
        for result in json["data"].arrayValue {
            let title = result["name"].stringValue
            let body = result["symbol"].stringValue
            let sigs = result["website_slug"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            petitions.append(obj)
        }
        
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numbers of row: \(petitions.count)")
        return petitions.count
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        
        // cell.textLabel?.text = "Title goes here"
        //  cell.detailTextLabel?.text = "Subtitle goes here"
        
        
        
        
        
        return cell
    }
    
  
}




