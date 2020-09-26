//
//  SettingsViewController.swift
//  WatsonAshtonCE09
//
//  Created by Ashton Watson on 9/24/20.
//

import UIKit

protocol  ViewControllerDelegate: class {
    func myDelegate(_ controller: SettingsViewController, text: [UIColor])
}

class SettingsViewController: UIViewController {

    weak var delegate : ViewControllerDelegate?
    
    var colorChoice = [UIColor]()
    var viewColor = UIColor()
    var textColor = UIColor()
    var changesOccur = false
    var SaveButtonPressed = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Settings"
    }
    @IBAction func ThemeOne(_ sender: Any) {
        changesOccur = true
        viewColor = .yellow
        textColor = .gray
        
        self.view.backgroundColor = viewColor
        
        
        
    }
    
    @IBAction func ThemeTwo(_ sender: Any) {
        
        changesOccur = true
        viewColor = .black
        textColor = .brown
        self.view.backgroundColor = viewColor
    }
    
    @IBAction func ThemeThree(_ sender: Any) {
        changesOccur = true
        viewColor = .blue
        textColor = .red
        self.view.backgroundColor = viewColor
    }
    
    @IBAction func Save(_ sender: Any) {
        colorChoice.removeAll()
        SaveButtonPressed = true
        if changesOccur == true{
            
            colorChoice.append(viewColor)
            colorChoice.append(textColor)
            
            
            UserDefaults.standard.set(color: viewColor, forKey: "viewColor")
            
            UserDefaults.standard.set(color: textColor, forKey: "textColor")
            
        }
        
        
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func Reset(_ sender: Any) {
        
        SaveButtonPressed = true
        colorChoice.removeAll()
        
        viewColor = .white
        textColor = .black
        
        
        
        
        UserDefaults.standard.set(color: viewColor, forKey: "viewColor")
        
        UserDefaults.standard.set(color: textColor, forKey: "textColor")
        
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if SaveButtonPressed == true{
            
        
        delegate?.myDelegate(self, text: colorChoice)
        }
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
