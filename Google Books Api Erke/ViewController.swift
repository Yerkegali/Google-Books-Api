//
//  ViewController.swift
//  Google Books Api Erke
//
//  Created by Yerkegali Abubakirov on 10.10.16.
//  Copyright © 2016 Yerkegali Abubakirov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var books = [Book]()
    
    override func viewDidLoad() {
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getBooks (query: String) {
        let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(query)"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
            if(error != nil) {
                print(error?.localizedDescription)
            } else {
                let json = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: AnyObject]
                
                if let items = json["items"] as? [[String: AnyObject]] {
                    print("got items", items)
                
                    self.books = []
                    
                    for item in items {
                        if let volumeInfo = item["volumeInfo"] as? [String: AnyObject]{
                        let book = Book()
                            book.title = volumeInfo["title"] as? String
                            if let imageLinks = volumeInfo["imageLinks"] as? [String: String]{
                            book.imageURL = imageLinks["thumbnail"]
                                
                        }
                        self.books.append(book)
                    }
                }
                    
                print(self.books)
                    
                    DispatchQueue.main.async {
                         self.tableView.reloadData()
                    }
                    
                   
                }
            }
        }.resume()
        
        
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! BookItemTableViewCell
        
        cell.titleLabel.text = books[indexPath.row].title!
        cell.coverImageView.imageFromUrl(urlString: books[indexPath.row].imageURL!)
        
        
        return cell
        
    }
}



extension ViewController : UISearchBarDelegate{
 
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        let text = searchBar.text
        print(text)
        
        self.getBooks(query: text!)
    }
}


extension UIImageView{

    public func imageFromUrl(urlString: String){
    
        if let url = URL(string: urlString){
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if(error != nil){
            print(error?.localizedDescription)
            } else {
                    if let image = UIImage(data: data!){
                    DispatchQueue.main.async {
                        self.image = image
                        }
                    }
                }
            }).resume()
        }
    }
    
}
