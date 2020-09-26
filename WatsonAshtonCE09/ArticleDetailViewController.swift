//
//  ArticleDetailViewController.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/23/20.
//

import UIKit
import SafariServices

class ArticleDetailViewController: UIViewController {

    var incomingArticle: Article!
    
    @IBOutlet weak var articleThumbNail: UIImageView!
    @IBOutlet weak var articleTitle: UITextView!
    @IBOutlet weak var articleDescription: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var relaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var articleAuthor: UILabel!
    @IBOutlet weak var articleDate: UILabel!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        
        articleThumbNail.image = incomingArticle.image
        articleTitle.text = incomingArticle.title
        articleDescription.text = incomingArticle.description
        
        if incomingArticle.author == ""{
            articleAuthor.text = "No author name found!"
        }
        else{
            
            articleAuthor.text = incomingArticle.author
        }
        
        print(incomingArticle.author)
        articleDate.text = incomingArticle.date

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
        if let viewColor = UserDefaults.standard.color(forKey: "viewColor") {
            
            view.backgroundColor = viewColor
        }
        
        if let titleColor = UserDefaults.standard.color(forKey: "textColor"){
        
            articleTitle.textColor = titleColor
            articleDescription.textColor = titleColor
            articleAuthor.textColor = titleColor
            articleDate.textColor = titleColor
            authorLabel.textColor = titleColor
            relaseDateLabel.textColor = titleColor
            descriptionLabel.textColor = titleColor
            
            
            
        }
        
   
    }
    
    
    @IBAction func GoToSource(_ sender: Any) {
        
        
        let videoLink = URL(string: incomingArticle.url)
        let safariVC = SFSafariViewController(url: videoLink!)
        present(safariVC, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
