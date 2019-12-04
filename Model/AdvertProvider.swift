import Foundation

class AdvertProvider {
    init(advertId: String){
        self.loadAdvertsData(id: advertId)
    }
    func loadAdvertsData(id: String) {
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "lomiren.kz"
            components.path = "/intern/advert/\(id)"
            
            return components.url
        }
        if let link = url {
            URLSession.shared.dataTask(with: link) {(data, response, error) in
                if error != nil {
                    print(error!)
                } else {
//                    var advertDetail: Advert
                    guard let data = data else { return }
                    do {
                        let response = try JSONDecoder().decode(AdvertResponse.self, from: data)
                        let advert = response.data
//                        advertDetail = advert
                        print(advert)
                        DispatchQueue.main.async {
//                            completion(advertDetail)
                            NotificationCenter.default.post(name: Notification.Name("advertDetail"), object: advert, userInfo: nil)
                        }
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                    
                }
            }.resume()
        }
    }
}
