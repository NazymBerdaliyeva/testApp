import UIKit
import JGProgressHUD

class AdvertsTableViewController: UITableViewController {

    var category: Category?
    var advertsProvider: AdvertsProvider?
    var adverts: [Adverts] = []
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        guard let id = category?.id else {return}
        advertsProvider = AdvertsProvider(categoryId: id)
        NotificationCenter.default.addObserver(self, selector: #selector(getAdverts), name: Notification.Name("advertsTransfer"), object: nil)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300
        self.title = category?.title
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    @objc func getAdverts(notif: Notification) {
        if let adverts = notif.object as? [Adverts] {
            self.adverts = adverts
            self.hud.dismiss(animated: true)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AdvertDetails" {
            if let cell = sender as? AdvertsTableViewCell {
                if let indexPath = tableView.indexPath(for: cell) {
                    let avdert = adverts[indexPath.row]
                    let detailVC = segue.destination as? AdvertViewController
                    detailVC?.advertId = avdert.id
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adverts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let advert = adverts[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AdvertsCell", for: indexPath) as? AdvertsTableViewCell {
            cell.titleLabel.text = advert.title
            cell.descriptionTextView.text = advert.description
            
            let url = URL(string: advert.image)
            
            if let url = url {
                let data = try? Data(contentsOf: url)
                if let data = data {
                    cell.advertsImageView.image = UIImage(data: data)
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
