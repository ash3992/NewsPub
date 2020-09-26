//
//  SourcesViewController.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/22/20.
//

import UIKit

class SourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ViewControllerDelegate {
   
    func myDelegate(_ controller: SettingsViewController, text: [UIColor]) {
        newColorArray = text
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loadText: UILabel!
 
    var newColorArray = [UIColor]()
    var arraySouces = [Sources]()
    
    var filterSources = [[Sources](), [Sources](), [Sources](), [Sources](), [Sources](), [Sources]()]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Sources"
        tableView.isHidden = true
        activityIndicator.startAnimating()
        JsonPull()
       tableView.isHidden = false
        loadText.isHidden = true
        activityIndicator.stopAnimating()
        
        // Do any additional setup after loading the view.
     
        
      
        tableView.reloadData()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
     
        if let viewColor = UserDefaults.standard.color(forKey: "viewColor") {
            
            view.backgroundColor = viewColor
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterSources[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier:"reuseIdentifier", for: indexPath) as? SourcesTableViewCell
            else{
                return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        }
        let currentPost = filterSources[indexPath.section][indexPath.row]
        
        cell.name.text = currentPost.name
        
        if let titleColor = UserDefaults.standard.color(forKey: "textColor"){
            cell.name.textColor = titleColor
            
        }
        return cell
        
    }
    
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    
     func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
          switch section {
              case 0:
                  return "General"
              case 1:
                  return "Business"
              case 2:
                  return "Technology"
          case 3:
            return "Sports"
          case 4:
            return "Enterainment"
          case 5:
            return "Science"
              default:
                  return "Oops should not happen here"
              }
        
        
    }
    func filter(){
        
        filterSources[0] = arraySouces.filter({$0.category == "general"})
        filterSources[1] = arraySouces.filter({$0.category == "business"})
        filterSources[2] = arraySouces.filter({$0.category == "technology"})
        filterSources[3] = arraySouces.filter({$0.category == "sports"})
        filterSources[4] = arraySouces.filter({$0.category == "entertainment"})
        filterSources[5] = arraySouces.filter({$0.category == "science"})

        print(filterSources[0].count)
        print(filterSources[1].count)
        print(filterSources[2].count)
        print(filterSources[3].count)
        print(filterSources[4].count)
        print(filterSources[5].count)
      
        
    }
    
    
    
    func JsonPull (){
        
        
        
        //create a default configuration
        let config = URLSessionConfiguration.default
        
        //create session
        let session = URLSession(configuration: config)
        
        //validate the url
        if let validURL = URL(string: "https://newsapi.org/v1/sources?language=en"){
            
            
            //create a urlRequest passing in validURL for our header
            var request = URLRequest(url: validURL)
            
            
            //set the header vaules
        //    request.setValue("vRW0TZEPL4lv4uLVT6iZICPbl3BpefwKzgcANF9S", forHTTPHeaderField: "X-API-Key")
            
            //type of requset
            request.httpMethod = "GET"
            
            let task = session.dataTask(with: request, completionHandler: { (opt_data, opt_response, opt_error) in
            
             //Bail Out on error
                           if opt_error != nil { assertionFailure(); return }

                           //Check the response, statusCode, and data
                           guard let response = opt_response as? HTTPURLResponse,
                               response.statusCode == 200,
                               let data = opt_data
                               else { assertionFailure(); return
                           }
            
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                        
                        guard let results = json["sources"] as? [[String: Any]]
                          
                        //    let members = results["members"] as? [[String: Any]]
                            else {print("nope not working"); return}
                        for child in results{
                            
                        
                        
                                guard
                                    let id = child["id"] as? String,
                                    let name = child["name"] as? String,
                                    let category = child["category"] as? String
                            
                                    else{
                                        return
                                }
                        
                            self.arraySouces.append(Sources(id: id, name: name, category: category))
                                print("\(name) id is \(id) and its catogory is \(category)")
                            
                            print(self.arraySouces.count)
                            }
                            
                            
                    }
                      
                        
               
                    
                }
                catch{
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    
                self.filter()
                    self.tableView.reloadData()
                  
                }
            })
            
            task.resume()
        }
        
        
        
        
        
        
        
        
      
        
    }
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let indexPath = tableView.indexPathForSelectedRow{
            let postToSend = filterSources[indexPath.section][indexPath.row]
            
            
            if let des = segue.destination as? AtriclesViewController{
                
                des.incomingSource = postToSend
            }
            
        }
     
    }
    

}
