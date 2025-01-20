//
//  ViewController.swift
//  HelloMovie
//
//  Created by Willy Hsu on 2025/1/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var movie:[Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchMovie()
        // Do any additional setup after loading the view.
    }
    func fetchMovie() {
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = queryItems
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhNzA0YzFlZTRmMTIxNGNlYmJiNWE0M2MwMTk4NmRiYiIsIm5iZiI6MTczNzAxMjI5NC4yMzQsInN1YiI6IjY3ODhiNDQ2ODY3N2JkZmFkZmFkMTg5ZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t6DgbkLEfmuAFYGEXrPnG7qyP9-FLGR0cLwCuGsBOiE"
        ]
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(PopularMovieData.self, from: data)
                DispatchQueue.main.async {
                    self.movie = result.results
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieTableViewCell
        let movie = movie[indexPath.row]
        cell.titleLabel.text = movie.title
        print("\(movie.title)")
        cell.ratingLabel.text = String(movie.vote_average)
        print("\(movie.vote_count)")
        cell.release_dateLabel.text = movie.release_date
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "熱門電影"
    }
}
