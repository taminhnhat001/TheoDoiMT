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

    var gioArr:[String] = [] //Mảng lưu các giá trị GIỜ (Trục x)
    var valueGioArr:[Double] = [] //Mảng lưu thông số của giá trị theo giờ (Trục y)
    var dateArr:[String] = [] //Mảng lưu các giá trị NGÀY (Trục x)
    var valueDateArr:[Double] = [] //Mảng lưu thông số của giá trị theo ngày (Trục y)
    var isHourBarSelected:Bool = true //Biến kiểm tra biểu đồ GIỜ được chọn
    var isDateBarSelected:Bool = false //Biến kiểm tra biểu đồ NGÀY được chọn
    
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
        //Set giá trị cho mảng Hour
        gioArr = ["01:00","02:00","03:00","04:00","05:00","06:00",
                  "07:00","08:00","09:00","10:00","11:00","12:00",
                  "13:00","14:00","15:00","16:00","17:00","18:00",
                  "19:00","20:00","21:00","22:00","23:00","24:00"]
        valueGioArr = [110,110,125,120,146,137,53,51,62,123,62,91,33,167,110,85,92,44,120,95,104,107,132,165]
        //Set giá trị cho mảng Date
        dateArr = ["1", "2", "3", "4", "5", "6",
                   "7", "8", "9", "10", "11", "12",
                   "13", "14", "15", "16", "17", "18",
                   "19", "20", "21", "22", "23", "24",
                   "25", "26", "27", "28", "29", "30", "31"]
        valueDateArr = [85,92,110,33,42,152,94,18,120,110,45,32,67,83,92,95,167,152,124,145,124,34,45,62,71,89,120,167,129,130,141]
        
        isHourBarSelected = true
        isDateBarSelected = false
        setHourBarChart(name: gioArr, value: valueGioArr)
    }
    
    //Biểu đồ Hour
    func setHourBarChart(name:[String], value:[Double]) {
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
        let dataSet:BarChartDataSet = BarChartDataSet(entries: dataArr, label: "Chỉ số ô nhiễm")
        //Check giá trị rồi set màu tương ứng
        dataSet.colors = [setColorBarChart(value: valueGioArr[0]), setColorBarChart(value: valueGioArr[1]), setColorBarChart(value: valueGioArr[2]),
                          setColorBarChart(value: valueGioArr[3]), setColorBarChart(value: valueGioArr[4]), setColorBarChart(value: valueGioArr[5]),
                          setColorBarChart(value: valueGioArr[6]), setColorBarChart(value: valueGioArr[7]), setColorBarChart(value: valueGioArr[8]),
                          setColorBarChart(value: valueGioArr[9]), setColorBarChart(value: valueGioArr[10]), setColorBarChart(value: valueGioArr[11]),
                          setColorBarChart(value: valueGioArr[12]), setColorBarChart(value: valueGioArr[13]), setColorBarChart(value: valueGioArr[14]),
                          setColorBarChart(value: valueGioArr[15]), setColorBarChart(value: valueGioArr[16]), setColorBarChart(value: valueGioArr[17]),
                          setColorBarChart(value: valueGioArr[18]), setColorBarChart(value: valueGioArr[19]), setColorBarChart(value: valueGioArr[20]),
                          setColorBarChart(value: valueGioArr[21]), setColorBarChart(value: valueGioArr[22]), setColorBarChart(value: valueGioArr[23])]
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
        //Chuyển các label giờ xuống dưới bot
        myBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        let dataChart:BarChartData = BarChartData(dataSet: dataSet)
        myBarChartView.data = dataChart
    }
    
    //Biểu đồ Date
    func setDateBarChart(name:[String], value:[Double]) {
        //Nếu không có dữ liệu thì:
        myBarChartView.noDataText = "Không có dữ liệu"
        //Hiện tên trục X theo tên giờ
        myBarChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dateArr)
        myBarChartView.xAxis.granularity = 1
        
        var dataArr:[BarChartDataEntry] = []
        for i in 0 ..< dateArr.count {
            let data:BarChartDataEntry = BarChartDataEntry(x: Double(i), y: value[i])
            dataArr.append(data)
        }
        let dataSet:BarChartDataSet = BarChartDataSet(entries: dataArr, label: "Chỉ số ô nhiễm")
        //Check giá trị rồi set màu tương ứng
        dataSet.colors = [setColorBarChart(value: valueDateArr[0]), setColorBarChart(value: valueDateArr[1]), setColorBarChart(value: valueDateArr[2]),
                          setColorBarChart(value: valueDateArr[3]), setColorBarChart(value: valueDateArr[4]), setColorBarChart(value: valueDateArr[5]),
                          setColorBarChart(value: valueDateArr[6]), setColorBarChart(value: valueDateArr[7]), setColorBarChart(value: valueDateArr[8]),
                          setColorBarChart(value: valueDateArr[9]), setColorBarChart(value: valueDateArr[10]), setColorBarChart(value: valueDateArr[11]),
                          setColorBarChart(value: valueDateArr[12]), setColorBarChart(value: valueDateArr[13]), setColorBarChart(value: valueDateArr[14]),
                          setColorBarChart(value: valueDateArr[15]), setColorBarChart(value: valueDateArr[16]), setColorBarChart(value: valueDateArr[17]),
                          setColorBarChart(value: valueDateArr[18]), setColorBarChart(value: valueDateArr[19]), setColorBarChart(value: valueDateArr[20]),
                          setColorBarChart(value: valueDateArr[21]), setColorBarChart(value: valueDateArr[22]), setColorBarChart(value: valueDateArr[23])]
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
        //Chuyển các label giờ xuống dưới bot
        myBarChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        
        let dataChart:BarChartData = BarChartData(dataSet: dataSet)
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
    //Chọn GIỜ
    @IBAction func actionGio(_ sender: UIButton) {
        isHourBarSelected = true
        isDateBarSelected = false
        lblGio.layer.borderColor = UIColor.darkText.cgColor
        lblNgay.layer.borderColor = UIColor.gray.cgColor
        lblGio.textColor = UIColor.white
        lblNgay.textColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblGio.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblNgay.backgroundColor = UIColor.white
        setHourBarChart(name: gioArr, value: valueGioArr)
        myBarChartView.reloadInputViews()
    }
    //Chọn NGÀY
    @IBAction func actionNgay(_ sender: UIButton) {
        isHourBarSelected = false
        isDateBarSelected = true
        lblNgay.layer.borderColor = UIColor.darkText.cgColor
        lblGio.layer.borderColor = UIColor.gray.cgColor
        lblNgay.textColor = UIColor.white
        lblGio.textColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblNgay.backgroundColor = UIColor(red: 91/255, green: 155/255, blue: 213/255, alpha: 1) //Xanh nuoc bien nhat
        lblGio.backgroundColor = UIColor.white
        setDateBarChart(name: dateArr, value: valueDateArr)
        myBarChartView.reloadInputViews()
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
        if isHourBarSelected == true {
            let pos = NSInteger(entry.x)
            let valueInt:Int = Int(valueGioArr[pos])
            lblAQI.text = String(valueInt)
        }
        if isDateBarSelected == true {
            let pos = NSInteger(entry.x)
            let valueInt:Int = Int(valueDateArr[pos])
            lblAQI.text = String(valueInt)
        }
    }
}
