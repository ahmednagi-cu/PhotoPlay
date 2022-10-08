//
//  ApiCaller.swift
//  PhotoPlay
//
//  Created by ahmed nagi on 30/09/2022.
//

import Foundation
import UIKit
struct Constants {
    static let API_Key = "5bd06668adc60b7d8dba2477590c0208"
    static let base_URL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyABGaZmoHlrmqRJpmmWGNBZkxzhRFDbPiM"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}
enum APIError : Error {
    case failedToGetData
}
class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/trending/movie/day?api_key=\(Constants.API_Key)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data , error == nil else { return }
            do {
                // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
                //print(result.results[0].original_title)
            }catch{
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getTrendingTv(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/trending/tv/day?api_key=\(Constants.API_Key)") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
               // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    func getPopularMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/popular?api_key=\(Constants.API_Key)&language=en-US&page=1") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
               // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func getUpcomingMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/upcoming?api_key=\(Constants.API_Key)&language=en-US&page=1") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
               // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func getTopratedMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/movie/top_rated?api_key=\(Constants.API_Key)&language=en-US&page=1") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
               // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
        
    }
    
    func getDiscoverMovies(completion : @escaping (Result<[Title],Error>) -> Void){
        guard let url = URL(string: "\(Constants.base_URL)/3/discover/movie?api_key=\(Constants.API_Key)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {
             return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
               // let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getSearchMovies(with query: String, completion : @escaping (Result<[Title],Error>) -> Void){
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constants.base_URL)/3/search/movie?api_key=\(Constants.API_Key)&query=\(query)") else {
             return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
              
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
    func getMovie(with query : String, completion : @escaping (Result<VideoElement,Error>) -> Void){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(Constants.YoutubeBaseURL)q=\(query)&key=\(Constants.YoutubeAPI_KEY)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data , error == nil else {
                return
            }
            do {
              
                let result = try JSONDecoder().decode(YoutubeSearchResult.self, from: data)
               // print(result)
                completion(.success(result.items[0]))
                
            }catch {
               completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        task.resume()
        
    }
}






