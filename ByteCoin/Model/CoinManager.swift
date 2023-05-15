//
//  CoinManager.swift
//  ByteCoin
//


import Foundation

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "FDAE8BE83A4D41FA88F7046EFF4BBE54"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String){
        let url = " \(baseURL)/\(currency)?apikey=\(apiKey)"
        print(url)
        performRequest(with: url)
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data,response,error) in
               if error != nil{
                   // self.delegate?.didFailWithError(error: error!)
                  return
               }
                if let safeData = data{
                    let stringData = String(data: safeData, encoding: String.Encoding.utf8)
                    print(stringData!)
                   if let price = self.parseJSON(safeData){
                      //  self.delegate?didUpdateWeather(self, weather:weather)
                       
                   }
                }
            }

            task.resume()
        }

    }
    
    
    func parseJSON(_ data : Data) -> Double? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(coinData.self, from: data)
            let lastPrice = decodedData.price
            print(lastPrice)
            return lastPrice
        }
        catch{
           // delegate?.didFailWithError(self, error : error)
            return nil
            
        }
    }
    
}
