import Foundation

class CategoryProvider {
    init(){
        self.loadCategoryData()
    }
    func loadCategoryData() {
        guard let url = URL(string: "https://lomiren.kz/intern/category") else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            if error != nil {
                print(error!)
            } else {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(CategoryListResponse.self, from: data)
                    let categories = response.data
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name("categoriesTransfer"), object: categories, userInfo: nil)
                    }
                } catch let jsonErr {
                    print("Error serializing json:", jsonErr)
                }
            }
        }.resume()
    }
}
