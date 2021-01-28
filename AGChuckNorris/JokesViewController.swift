//
//  JokesViewController.swift
//  AGChuckNorris
//
//  Created by Admin on 24.01.2021.
//  Copyright © 2021 AlexGermek. All rights reserved.
//

import UIKit

class JokesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var jokesTableView: UITableView!
    @IBOutlet weak var loadJokesButton: UIButton!
    @IBOutlet weak var jokesCountLabel: UILabel!
    @IBOutlet weak var jokesCountSlider: UISlider!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var maxJokesCount = 500
    
    var jokes: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.jokesTableView.delegate = self
        self.jokesTableView.dataSource = self
        
        self.jokesCountLabel.layer.cornerRadius = 50
        
        // 1. При запуске приложения получаю максимальное количество шуток на сайте
        //и устанавливаю слайдеру и лэйблу соответствующие значения
        getMaxCountJokes { [unowned self] (maxCount) in
            
        DispatchQueue.main.async {
            self.maxJokesCount = maxCount
            self.jokesCountSlider.maximumValue = Float(self.maxJokesCount)
            
            let mid = self.maxJokesCount / 2
            self.jokesCountSlider.value = Float(mid)
            self.jokesCountLabel.text   = "\(mid)"
            self.indicator.stopAnimating()
            self.loadJokesButton.isEnabled  = true
            self.jokesCountSlider.isEnabled = true
        }
    }
}
    
    //MARK: UITableViewDelegate ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    // 1. Число строк в секции:
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jokes.count
    }
    
    // 2. Создание ячейки для секции и строки:
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

           let cellIdentifier = "joke_cell"
           let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
           
            cell.textLabel?.text = self.jokes[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.lineBreakMode = .byWordWrapping
            
            cell.textLabel?.backgroundColor = .white
        
            if indexPath.row % 2 == 0 {
                cell.textLabel?.backgroundColor = #colorLiteral(red: 0.8100239635, green: 0.8662588, blue: 0.9038543701, alpha: 1)
            }
        
           return cell
       }
    //UITableViewDelegate ----------------------------------------------------------------------------------------
    
    
    
    //MARK: Actions +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    // 1. Кнопка Load:
    @IBAction func actionLoadButton(_ sender: UIButton) {
        
        self.jokes.removeAll(keepingCapacity: false)
        
        let currentCount = Int(jokesCountLabel.text!)!
        
        self.indicator.startAnimating()
        
        getJokes(withCount: currentCount) { [unowned self] (jokes) in
           
            DispatchQueue.main.async {
                for joke in jokes{
                    self.jokes.append(joke.joke)
                }
                
                self.jokesTableView.reloadData()
                self.indicator.stopAnimating()
            }

        }
    }
    
    // 2. Изменение Количества шуток в Label при изменении Slider'a:
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        
        let currentValue = Int(sender.value)
            
        self.jokesCountLabel.text = "\(currentValue)"
    }
    //Actions ----------------------------------------------------------------------------------------------------
    
    
    //MARK: My functions +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    // 1. При запуске приложения получаю с сайта общее количество шуток:
    func getMaxCountJokes(completion: @escaping (_ maxJ: Int) -> ()){
        
            let url = URL(string: "http://api.icndb.com/jokes/count")!
            let session = URLSession.shared

            session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("error=\(error!)")
                    return
                }
                
                let decoder = JSONDecoder()
                if let data = data,
                    let maxJokesCount = try? decoder.decode(MaxJokesCount.self, from: data){
                    completion(maxJokesCount.value)
                }
            }.resume()
    }
    
    // 2. Получаю шутки в количестве, которое выбрал пользователь:
    func getJokes(withCount count: Int, completion: @escaping (_ rJ: [Joke]) -> ()){

            let url = URL(string: "http://api.icndb.com/jokes/random/\(count)")!
            let session = URLSession.shared

            session.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    print("error=\(error!)")
                    return
                }
                
                let decoder = JSONDecoder()
                if let data = data,
                    let randomJokes = try? decoder.decode(RandomJokes.self, from: data){
                    completion(randomJokes.value)
                    
                }
            }.resume()
    }
    //My functions ----------------------------------------------------------------------------------------------------
}
