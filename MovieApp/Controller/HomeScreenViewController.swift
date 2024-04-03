//
//  HomeScreenViewController.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

import UIKit
import Kingfisher
class HomeScreenViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var results: [Result]?
    var filterValue:String?
    var containValueOfButton = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        apiCallForMovieList()
    }

    func registerNib() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    }
    
    @IBAction func filterButton(_ sender: Any) {
            let nav = FilterPopupViewController()
            nav.containValueOfButton = containValueOfButton
            let navi = UINavigationController(rootViewController: nav)
            navi.providesPresentationContextTransitionStyle = true
            navi.definesPresentationContext = true
            navi.modalTransitionStyle = .coverVertical
            navi.hidesBottomBarWhenPushed = true
            navi.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            nav.view.backgroundColor = UIColor.init(white: 0.4, alpha: 0.8)
            nav.completionHandler = { value in
                
                print("Received value in parent view controller: \(value)")
                if "Received value in parent view controller: Title" == "Received value in parent view controller: \(value)" {
                    self.filterValue = "original_title"
                    self.containValueOfButton = 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        self.apiCallForMovieList()
                    }
                    print("Received value in parent view controller: \(value)")
                }else if "Received value in parent view controller: ReleaseDate" == "Received value in parent view controller: \(value)" {
                    self.filterValue = "release_date"
                    self.containValueOfButton = 2
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        self.apiCallForMovieList()
                    }
                    print("Received value in parent view controller: \(value)")
                }
            }
            self.present(navi, animated: false, completion: nil)
    }
    
    //MARK: Api call to get data
    func apiCallForMovieList(){
        fetchPopularMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieListResponse):
                    self.results = movieListResponse.results ?? []
                    print("Received movie list response: \(movieListResponse)")
                    self.tableView.reloadData()
                   
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }

    }
    
    
}


extension HomeScreenViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }
        if filterValue == "release_date" {
            cell.releaseDateLabel.isHidden = false
            cell.releaseDateLabel.text = "Release_date: \(results?[indexPath.row].releaseDate ?? "")"
        }else{
            cell.releaseDateLabel.text = ""
            cell.releaseDateLabel.isHidden = true
        }
        cell.movieName.text = results?[indexPath.row].originalTitle ?? ""
        if let imageURL = URL(string: "https://image.tmdb.org/t/p/original/\(results?[indexPath.row].posterPath ?? "")"){
            cell.movieImage?.kf.setImage(with: imageURL)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension HomeScreenViewController {
    func fetchPopularMovies(completion: @escaping (Swift.Result<MovieListResponseModel, Error>) -> Void) {
        //MARK: Url use
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&sort_by=\(filterValue ?? "")") else {
            print("Invalid URL")
            return
        }
        
        //MARK: Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhMWE3ZDAxZWQ2ZGRkYTc5NTRhY2Q4NTdkYTQ1MGZmMSIsInN1YiI6IjY1ZmFhYjIyMGJjNTI5MDE2MmFkZWIxMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-9-lBOZF1tUzeuNj9aXRtWwbp0Km1SOLSwPun3_kfmE", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        //MARK: Create URLSession task
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                completion(.failure(NSError(domain: "HTTPError", code: statusCode, userInfo: nil)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "NoDataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let movieListResponse = try decoder.decode(MovieListResponseModel.self, from: data)
                completion(.success(movieListResponse))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
