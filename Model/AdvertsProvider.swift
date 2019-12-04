import Foundation

class AdvertsProvider {
    init(categoryId: String){
        self.loadAdvertsData(id: categoryId)
    }
    func loadAdvertsData(id: String) {
        var url: URL? {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "lomiren.kz"
            components.path = "/intern/category_adverts/\(id)"
            
            return components.url
        }
        if let link = url {
            URLSession.shared.dataTask(with: link) {(data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    guard let data = data else { return }
                    do {
                        let response = try JSONDecoder().decode(AdvertsListResponse.self, from: data)
                        let adverts = response.data
                        DispatchQueue.main.async {
                            NotificationCenter.default.post(name: Notification.Name("advertsTransfer"), object: adverts, userInfo: nil)
                        }
                    } catch let jsonErr {
                        print("Error serializing json:", jsonErr)
                    }
                }
            }.resume()
        }
       
    }
}
