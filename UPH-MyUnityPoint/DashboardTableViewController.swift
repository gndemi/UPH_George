//
//  DashboardTableViewController.swift
//  UPH-MyUnityPoint
//
//  Created by Aakash Sheth on 3/20/16.
//  Copyright © 2016 Aakash Sheth. All rights reserved.
//

import UIKit

class DashboardTableViewController: UITableViewController {
    
    // MARK: Properties
    var dashboardItems = [DashboardItem]()
    
    func loadSampleData() {
        
        // Single image for all items
        let photo = UIImage(named: "heart")!
        
        // Create the individual items
        let heartRate = DashboardItem(type: "Heart Rate", value: "72", description: "68 BPM, 3m ago", photo: photo, label: "BPM")!
        let steps = DashboardItem(type: "Steps", value: "4,509", description: "2.14 Miles", photo: photo, label: "Steps")!
        let calories = DashboardItem(type: "Calories", value: "750", description: "Keep it up!", photo: photo, label: "Calories")!
        
        dashboardItems += [heartRate, steps, calories]
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadSampleData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dashboardItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        // Custom cell name
        let cellIdentifier = "DashboardItemTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DashboardItemTableViewCell
        
        let dashboardItem = dashboardItems[indexPath.row]
        
        cell.CardDescription.text = dashboardItem.description
        cell.CardImage.image = dashboardItem.photo
        cell.CardType.text = dashboardItem.type
        cell.CardValue.text = dashboardItem.value
        cell.CardLabel.text = dashboardItem.label
        


        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
