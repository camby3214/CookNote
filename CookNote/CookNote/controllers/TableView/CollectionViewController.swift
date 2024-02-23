//
//  CollectionViewController.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/8/5.
//

import UIKit


class CollectionViewController: UICollectionViewController {

    let dao = CookbooksDAO.shared
    var list = [Cookbooks]()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        collectionView.dataSource = self
        collectionView.delegate = self
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        list = CookbooksDAO.shared.getCookbooksByFavorite()
        collectionView.reloadData()
//        collectionView.collectionViewLayout =
       
        
//        print(list.count)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "next", sender: collectionView)
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    var rid1 = -1
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        let data = list[indexPath.item]
        let rid = data.rid
        rid1 = rid
        cell.nameLabel?.text = data.food
        if let foodPhoto = data.foodPhoto{
            cell.foodPhoto?.image = UIImage(data: foodPhoto)
        }
        cell.layer.cornerRadius = 20
        cell.layer.masksToBounds = true
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            if let next = segue.destination as? CookPageViewController, let indexPath = self.collectionView!.indexPathsForSelectedItems {
                next.foodNum = list[indexPath.first!.row].rid
            }
        }
    }
}

//self.collectionView!.indexPathForCell(cell)
