//
//  ThemisAssistanceTableViewController.swift
//  Themis
//
//  Created by Thor on 8/19/16.
//  Copyright © 2016 Thor. All rights reserved.
//

import UIKit

class ThemisAssistanceTableViewController: UITableViewController {

    var names = [ThemisObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        names = [ThemisObject(n: "Assistance Request", d: "Select to request assistance"),
                 ThemisObject(n: "Assistance Volunteer", d: "Select to volunteer assistance")
        ]
        self.tableView.backgroundColor = UIColor.purple


        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as UITableViewCell!
        if (cell != nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "CellName")
        }
        let labelName = names[indexPath.row]
        
        cell?.backgroundColor? = UIColor.clear
        
        
        cell?.textLabel?.font = UIFont(name: "Times New Roman", size: 18)
        cell?.textLabel?.textColor = UIColor.white
        cell?.detailTextLabel?.textColor = UIColor.yellow
        
        cell?.textLabel?.text = labelName.n
        cell?.detailTextLabel?.text = labelName.d
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let url = "https://redcap.lbrn.lsu.edu/surveys/?s=Y3C9N7FENC"
            
            let alertOpenSafariForAidRequest = { (action:UIAlertAction!) -> Void in
                UIApplication.shared.openURL(URL(string: url)!)
            }
            let assistAlert = UIAlertController(title: "Request Assistance", message: "This will open a survey in Redcap to securely gather information.", preferredStyle: UIAlertControllerStyle.alert)
            let launchSurvey = UIAlertAction(title: "Ok", style: .default, handler: alertOpenSafariForAidRequest)
            let noLaunchSurvey = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            assistAlert.addAction(launchSurvey)
            assistAlert.addAction(noLaunchSurvey)
            self.present(assistAlert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        if indexPath.row == 1 {
            let url = "https://redcap.lbrn.lsu.edu/surveys/?s=8TA39Y4YPL"
            let alertOpenSafariForVolunteerAid = { (action:UIAlertAction!) -> Void in
                UIApplication.shared.openURL(URL(string: url)!)
            }
            let assistAlert = UIAlertController(title: "Volunteer Assistance", message: "This will open a survey in Redcap to securely gather information.", preferredStyle: UIAlertControllerStyle.alert)
            let launchSurvey = UIAlertAction(title: "Ok", style: .default, handler: alertOpenSafariForVolunteerAid)
            let noLaunchSurvey = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            assistAlert.addAction(launchSurvey)
            assistAlert.addAction(noLaunchSurvey)
            self.present(assistAlert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
            
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
