//
//  FirstTableViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/29.
//

import UIKit

class FirstTableViewController: UITableViewController, UISearchResultsUpdating , UISearchBarDelegate{
    
    
    var searching = false
    var searchedCookbooksList = [Cookbooks]()
    let searchController = UISearchController(searchResultsController: nil)
    var list = [Cookbooks]()
    var list2 = [Cookbooks]()
    var overList = [Cookbooks]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FirstTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier:"FirstTableViewCell")
        let nib2 = UINib(nibName: "SecondTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier:"SecondTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        configureSearchController()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }

    private func configureSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.search
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search Cookbooks by name"
        
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        list = CookbooksDAO.shared.getAllCookbooks()
        list2 = CookbooksDAO.shared.getCookbooksByFavorite()
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
            cell.rid = data.rid
            cell.favorite = data.favorite
            cell.authorName?.text = data.author
            cell.food?.text = data.food
            if data.favorite == 1 {
                cell.heart?.image = UIImage(named: "heart1")
            } else {
                cell.heart?.image = UIImage(named: "heartfill")
            }
            
            
            if let foodPhoto = data.foodPhoto{
                cell.img?.image = UIImage(data: foodPhoto)

            }
            if let authorPhoto = data.authorPhoto{
                cell.authorPhoto?.image = UIImage(data: authorPhoto)
                cell.authorPhoto.layer.cornerRadius = cell.authorPhoto.frame.height/2
            }
            
            return cell
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            return cell
        }
    
    }
    var isOn = false
    @objc func btnHandlerList(_ sender: Any) {
        
            
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if !searchText.isEmpty{
            searching = true
            list.removeAll()
            list = CookbooksDAO.shared.getCookbooksByName(searchText)
        } else {
            searching = false
            list.removeAll()
            list = CookbooksDAO.shared.getAllCookbooks()
        }
        tableView.reloadData()
    }
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


