//
//  ViewController.swift
//  exchanger
//
//  Created by Mrityunjay Kumar on 13/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textView: UILabel!
    
    let data = ["INR", "ETH", "USD", "JPY", "GBP", "CNY", "AED", "RUB", "KRW", "CHF"]
    
    var exchangeRateManager = ExchangeRateManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        exchangeRateManager.delegate = self
        
        exchangeRateManager.getExchangeRate(selectedCurrency: data[0])
    }


}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        textView.text = data[row]
        
        exchangeRateManager.getExchangeRate(selectedCurrency: data[row])
        
    }
}


extension ViewController: ExchangeRateDelegate {
    func getExchangeRateData(data: ExchangeRateModel) {
        print("called from manager to main view controller: found rate = \(data.rate)")
        DispatchQueue.main.async {
            self.textView.text = "\(data.rate.round(precision: 2))"
        }
    }
}

extension Double {
    func round(precision: Int) -> Double {
        var n = self
        let precisionNumber = pow(10, Double(precision))
        n = n * precisionNumber
        n.round()
        n = n / precisionNumber
        return n
    }
}
