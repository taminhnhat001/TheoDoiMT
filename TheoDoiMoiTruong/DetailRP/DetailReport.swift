//
//  DetailReport.swift
//  TheoDoiMoiTruong
//
//  Created by Duc on 4/15/20.
//  Copyright © 2020 Duc. All rights reserved.
//

import UIKit
import Charts

class DetailReport: UIViewController {

    var gioArr:[String] = []
    var valueArr:[Double] = []
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var myBarChartView: BarChartView!
    
    @IBOutlet weak var lblThu1: UILabel!
    @IBOutlet weak var viewThu1: UIView!
    @IBOutlet weak var lblThu2: UILabel!
    @IBOutlet weak var viewThu2: UIView!
    @IBOutlet weak var lblThu3: UILabel!
    @IBOutlet weak var viewThu3: UIView!
    @IBOutlet weak var lblGio: UILabel!
    @IBOutlet weak var lblNgay: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblAQI: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myBarChartView.delegate = self
        //UI Lịch Sử
        lblGio.layer.borderColor = UIColor.darkText.cgColor
        lblGio.layer.borderWidth = 1.0
        lblGio.layer.cornerRadius = 5
        lblGio.clipsToBounds = true
        lblNgay.layer.borderColor = UIColor.gray.cgColor
        lblNgay.layer.borderWidth = 1.0
        lblNgay.layer.cornerRadius = 5
        lblNgay.clipsToBounds = true
        //Set gia tri cho mang
        gioArr = ["01:00","02:00","03:00","04:00","05:00","06:00",
                  "07:00","08:00","09:00","10:00","11:00","12:00",
                  "13:00","14:00","15:00","16:00","17:00","18:00",
                  "19:00","20:00","21:00","22:00","23:00","24:00"]
        valueArr = [110,110,125,120,146,137,53,51,62,123,62,91,33,167,110,85,92,44,120,95,104,107,132,165]
        
        setBarChart(name: gioArr, value: valueArr)
    }
    
    func setBarChart(name:[String], value:[Double]) {
        //Nếu không có dữ liệu thì:
        myBarChartView.noDataText = "Không có dữ liệu"
        //Hiện tên trục X theo tên giờ
        myBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: gioArr)
        myBarChartView.xAxis.granularity = 1
        
        var dataArr:[BarChartDataEntry] = []
        for i in 0 ..< gioArr.count {
            let data:BarChartDataEntry = BarChartDataEntry(x: Double(i), y: value[i])
            dataArr.append(data)
        }
        var dataSet:BarChartDataSet = BarChartDataSet(entries: dataArr, label: "Chỉ số ô nhiễm")
        //Check giá trị rồi set màu tương ứng
        dataSet.colors = [setColorBarChart(value: valueArr[0]), setColorBarChart(value: valueArr[1]), setColorBarChart(value: valueArr[2]),
                          setColorBarChart(value: valueArr[3]), setColorBarChart(value: valueArr[4]), setColorBarChart(value: valueArr[5]),
                          setColorBarChart(value: valueArr[6]), setColorBarChart(value: valueArr[7]), setColorBarChart(value: valueArr[8]),
                          setColorBarChart(value: valueArr[9]), setColorBarChart(value: valueArr[10]), setColorBarChart(value: valueArr[11]),
                          setColorBarChart(value: valueArr[12]), setColorBarChart(value: valueArr[13]), setColorBarChart(value: valueArr[14]),
                          setColorBarChart(value: valueArr[15]), setColorBarChart(value: valueArr[16]), setColorBarChart(value: valueArr[17]),
                          setColorBarChart(value: valueArr[18]), setColorBarChart(value: valueArr[19]), setColorBarChart(value: valueArr[20]),
                          setColorBarChart(value: valueArr[21]), setColorBarChart(value: valueArr[22]), setColorBarChart(value: valueArr[23])]
        //Không hiện thông số trên mỗi bar
        dataSet.drawValuesEnabled = false
        //Ko hiện chú thích
        myBarChartView.legend.enabled = false
        //Ko hiện đường kẻ background
        myBarChartView.xAxis.drawGridLinesEnabled = false
        myBarChartView.leftAxis.drawGridLinesEnabled = false
        myBarChartView.rightAxis.drawGridLinesEnabled = false
        //Bỏ hiện giá trị bên phải
        myBarChartView.rightAxis.drawLabelsEnabled = false
        //Chuyển các label giờ xuống dưới bott
        myBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        
        var dataChart:BarChartData = BarChartData(dataSet: dataSet)
        myBarChartView.data = dataChart
    }
    
    //Màu tương ứng với giá trị trong BarChart
    func setColorBarChart(value: Double) ->UIColor {
        if (value > 0 && value <= 50) {
            return UIColor(red: 174/255, green: 231/255, blue: 102/255, alpha: 1) //Xanh la cay nhat.
        }
        else if (value > 50 && value <= 100) {
            return UIColor(red: 248/255, green: 217/255, blue: 76/255, alpha: 1) //Vang` nhat.
        }
        else if (value > 100 && value <= 150) {
            return UIColor(red: 232/255, green: 154/255, blue: 85/255, alpha: 1) //Cam nhat.
        }
        else if (value > 150) {
            return UIColor(red: 224/255, green: 155/255, blue: 155/255, alpha: 1) //Do nhat.
        }
        else {
            return UIColor.black
        }
    }

    //Action chọn từng ngày
    @IBAction func actionThu1(_ sender: UIButton) {
        myCollectionView.reloadData()
        lblThu1.textColor = UIColor.darkText //Den
        viewThu1.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh
        lblThu2.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu2.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        lblThu3.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu3.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
    }
    
    @IBAction func actionThu2(_ sender: UIButton) {
        myCollectionView.reloadData()
        lblThu2.textColor = UIColor.darkText //Den
        viewThu2.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh
        lblThu1.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu1.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        lblThu3.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu3.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
    }
    
    @IBAction func actionThu3(_ sender: UIButton) {
        myCollectionView.reloadData()
        lblThu3.textColor = UIColor.darkText //Den
        viewThu3.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh
        lblThu2.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu2.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        lblThu1.textColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
        viewThu1.backgroundColor = UIColor(red: 174/255, green: 171/255, blue: 171/255, alpha: 1) //Xam
    }
    
    //Action Lịch sử
    @IBAction func actionGio(_ sender: UIButton) {
        lblGio.layer.borderColor = UIColor.darkText.cgColor
        lblNgay.layer.borderColor = UIColor.gray.cgColor
        lblGio.textColor = UIColor.white
        lblNgay.textColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblGio.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblNgay.backgroundColor = UIColor.white
    }
    
    @IBAction func actionNgay(_ sender: UIButton) {
        lblNgay.layer.borderColor = UIColor.darkText.cgColor
        lblGio.layer.borderColor = UIColor.gray.cgColor
        lblNgay.textColor = UIColor.white
        lblGio.textColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblNgay.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblGio.backgroundColor = UIColor.white
    }
}

//Collection View
extension DetailReport: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? DetailRPCollectionViewCell
        return cell!
    }
}

//Bấm vào cột trong biểu đồ hiển thị chỉ số trên label AQI
extension DetailReport: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let pos = NSInteger(entry.x)
        let valueInt:Int = Int(valueArr[pos])
        lblAQI.text = String(valueInt)
    }
}
