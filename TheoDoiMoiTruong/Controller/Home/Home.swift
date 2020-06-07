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
    
    var arrThongSo3Ngay:[ThongSo3Ngay] = []
    var arrThongSoGio:[ThongSoGio] = []
    
    @IBOutlet weak var myTableHome: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        myTableHome.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        myTableHome.dataSource = self
        myTableHome.delegate = self
        myTableHome.tableFooterView = UIView()
        
        getThongSo3Ngay()
        
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
    
    @IBAction func addPlace(_ sender: UIButton) {
        
    }
    
    @IBAction func removePlace(_ sender: UIButton) {
        
    }
    
    func getThongSo3Ngay() {
        let urlString = "https://5ed9c5914378690016c6b36f.mockapi.io/api/thongso3ngay"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        arrThongSo3Ngay.removeAll()
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let myJson = json as? [[String:Any]] {
                        for myThongSo3NgayDic in myJson {
                            let myThongSo3Ngay = ThongSo3Ngay.init(dic: myThongSo3NgayDic)
                            self.arrThongSo3Ngay.append(myThongSo3Ngay)
                        }
                        
                        self.getThongSoGio()
                        
                    }
                    //                    DispatchQueue.main.async {
                    //                        self.myTableHome.reloadData()
                    //                    }
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
    }
    
    func getThongSoGio() {
        let urlString = "https://5ed9c5914378690016c6b36f.mockapi.io/api/thongsogio"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        
        arrThongSoGio.removeAll()
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let response = response {
                
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let myJson = json as? [[String:Any]] {
                        for myThongSoGioDic in myJson {
                            let myThongSoGio = ThongSoGio.init(dic: myThongSoGioDic)
                            self.arrThongSoGio.append(myThongSoGio)
                        }
                    }
                    DispatchQueue.main.async {
                        self.myTableHome.reloadData()
                    }
                }
                catch {
                    print (error)
                }
            }
        }
        task.resume()
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
    
    //delete Row
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
       
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            arrThongSoGio.remove(at: indexPath.row)
            arrThongSo3Ngay.remove(at: indexPath.row)
            print("Deleted")
            myTableHome.beginUpdates()
            myTableHome.deleteRows(at: [indexPath], with: .automatic)
            myTableHome.endUpdates()
        }
    }
}

extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrThongSo3Ngay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as? HomeTableViewCell {
            cell.lblThu1.text = arrThongSo3Ngay[indexPath.row].thu1
            cell.lblThu2.text = arrThongSo3Ngay[indexPath.row].thu2
            cell.lblThu3.text = arrThongSo3Ngay[indexPath.row].thu3
            cell.lblAQI_1.text = String(arrThongSo3Ngay[indexPath.row].aqi_thu1 ?? 0)
            cell.lblAQI_2.text = String(arrThongSo3Ngay[indexPath.row].aqi_thu2 ?? 0)
            cell.lblAQI_3.text = String(arrThongSo3Ngay[indexPath.row].aqi_thu3 ?? 0)
            cell.lblNhietDo_1.text = String(arrThongSo3Ngay[indexPath.row].nhietdo_thu1 ?? 0)
            cell.lblNhietDo_2.text = String(arrThongSo3Ngay[indexPath.row].nhietdo_thu2 ?? 0)
            cell.lblNhietDo_3.text = String(arrThongSo3Ngay[indexPath.row].nhietdo_thu3 ?? 0)
            cell.lblDoAm_1.text = String(arrThongSo3Ngay[indexPath.row].doam_thu1 ?? 0)
            cell.lblDoAm_2.text = String(arrThongSo3Ngay[indexPath.row].doam_thu2 ?? 0)
            cell.lblDoAm_3.text = String(arrThongSo3Ngay[indexPath.row].doam_thu3 ?? 0)
            
            if arrThongSoGio[indexPath.row].distric == arrThongSo3Ngay[indexPath.row].distric && arrThongSoGio[indexPath.row].province == arrThongSo3Ngay[indexPath.row].province {
                cell.lblDistrict.text = arrThongSo3Ngay[indexPath.row].distric
                cell.lblProvince.text = arrThongSo3Ngay[indexPath.row].province
                cell.lblNhietDoGio.text = String(arrThongSoGio[indexPath.row].nhietdo ?? 0)
                cell.lblDoAmGio.text = String(arrThongSoGio[indexPath.row].doam ?? 0)
                cell.lblAQIGio.text = String(arrThongSoGio[indexPath.row].aqi ?? 0)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}
