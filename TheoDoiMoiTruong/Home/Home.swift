//
//  Home.swift
//  TheoDoiMoiTruong
//
//  Created by Duc on 4/13/20.
//  Copyright © 2020 Duc. All rights reserved.
//

import UIKit

class Home: UIViewController {

    var menu_vc: MenuViewController!
    
    @IBOutlet weak var myTableHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        myTableHome.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        myTableHome.dataSource = self
        myTableHome.delegate = self
        myTableHome.tableFooterView = UIView()
        
        //Làm menu
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        //Swipe left, right to open/close menu
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            show_menu()
        }
         
        else if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            close_on_swipe()
        }
    }
    
    func close_on_swipe() {
        if AppDelegate.menu_bool == true {
            //show the menu
            //show_menu()
        }
        else {
            //close menu
            close_menu()
        }
    }

    @IBAction func menu_action(_ sender: UIBarButtonItem) {
        //show menu
        if AppDelegate.menu_bool == true {
            //show the menu
            show_menu()
        }
        else {
            //close menu
            close_menu()
        }
    }
    
    func show_menu() {
        //self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        UIView.animate(withDuration: 0.5) {
            self.menu_vc.view.frame = CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            self.addChild(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
        }
    }
    
    func close_menu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.width, y: 90, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }) { (finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        AppDelegate.menu_bool = true
    }
    
    @IBAction func addMore(_ sender: UIButton) {
        
    }
}

extension Home: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailReport") as? DetailReport
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell
        return cell!
    }
    
    
}
