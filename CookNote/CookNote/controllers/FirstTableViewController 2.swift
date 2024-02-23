//
//  FirstTableViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit

class FirstTableViewController: UITableViewController {
    @IBOutlet weak var search: UISearchBar!
    
    var list = [Cookbooks]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FirstTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"FirstTableViewCell")
        let nib2 = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier:"SecondTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        list = CookbooksDAO.shared.getAllCookbooks()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return list.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1:
            return 20
        default:
            return 400
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "next", sender: tableView)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            let data = list[indexPath.section]
            let rid = data.rid
            cell.authorName?.text = data.author
            cell.food?.text = data.food
            if let foodPhoto = data.foodPhoto{
                cell.img?.image = UIImage(data: foodPhoto)
            }

            if let authorPhoto = data.authorPhoto{
                cell.authorPhoto?.image = UIImage(data: authorPhoto)
            }
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            return cell
        }
    
    }
   
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "next" {
            if let next = segue.destination as? CookPageViewController, let indexPath = tableView.indexPathForSelectedRow {
//                next.rid = list[indexPath.row].rid
                next.foodNum = list[indexPath.section].rid
            }
        }
        
        
    }
    


}
