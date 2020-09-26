//
//  AtriclesViewController.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/22/20.
//

import UIKit

class AtriclesViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var tableView: UITableView!
    
    
    var incomingSource: Sources!
    var arrayAricle = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = incomingSource.name
        JsonPull(id: incomingSource.id)
      //  tableView.reloadData()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
   
        if let viewColor = UserDefaults.standard.color(forKey: "viewColor") {
            
            view.backgroundColor = viewColor
        }
        
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayAricle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath) as? ArticleTableViewCell
        
        else{return tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier2", for: indexPath)}
        
      
        cell.textView.text = arrayAricle[indexPath.row].title
        if let titleColor = UserDefaults.standard.color(forKey: "textColor"){
            cell.textView.textColor = titleColor
            
        }
       
        if let img = arrayAricle[indexPath.row].image{
            cell.thumbNail?.image = img
        }
        return cell

    }
    
    func JsonPull (id: String){
        
        
        
        //create a default configuration
        let config = URLSessionConfiguration.default
        
        //create session
        let session = URLSession(configuration: config)
        
        //validate the url
        if let validURL = URL(string: "https://newsapi.org/v1/articles?source=\(id)&apiKey=b6612c4ac4ec458db58f6f400a5e09fc"){
            
            
            //create a urlRequest passing in validURL for our header
            var request = URLRequest(url: validURL)
            
            
            //set the header vaules
           request.setValue("b6612c4ac4ec458db58f6f400a5e09fc", forHTTPHeaderField: "X-Api-Key")
     
            
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
                        
                        guard let results = json["articles"] as? [[String: Any]]
                          
                      
                            else {print("nope not working"); return}
                        for child in results{
                            
                        
                        
                                guard
                           
                                    let url = child["url"] as? String
                                
                             
                                    else{
                                        return
                                }
                            var a = String()
                            var d = String()
                            var p = String()
                            var des = String()
                            var t = String()
                            
                            if let title = child["title"] as? String{
                                if title == ""{
                                    t = "No title available"
                                }
                                else{
                                    
                                    t = title
                                }
                                
                            }
                            
                            if let description = child["description"] as? String{
                                if description == "null"{
                                    
                                    des = "n/a"
                                }else{
                                    
                                    des = description
                                }
                                
                                
                                
                            }
                            if let author = child["author"] as? String{
                                if author == "null"{
                                    
                                    a = "n/a"
                                    
                                }else{
                                    
                                    a = author
                                    
                                }
                                
                                
                                
                            }
                                if  let date = child["publishedAt"] as? String{
                                    if date == "null"{
                                        d = "n/a"
                                    }
                                    else{
                                        
                                        d = date
                                        
                                    }
                                   
                                    
                                }
                            
                            if let picture = child["urlToImage"] as? String{
                                if picture == "null"{
                                    
                                    p = "n/a"
                                }
                                else{
                                    
                                    p = picture
                                }
                            }
                            self.arrayAricle.append(Article(author: a, title: t, description: des, url: url, image: p, date: d))
                         
                            
                           print(t)
                            print(self.arrayAricle.count)
                            }
                            
                            
                    }
                      
                        
               
                    
                }
                catch{
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    
             //   self.filter()
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
            let postToSend = arrayAricle[indexPath.row]
        
        if let destination = segue.destination as? ArticleDetailViewController{
            
            destination.incomingArticle = postToSend
        }
    }
    }

}
