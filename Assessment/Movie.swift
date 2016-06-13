
import UIKit

enum Genre : String {
    case Horror, Drama, Comedy, Action
}

class Movie {
    let id: Int
    let title: String
    let description: String
    let genre: Genre
    let post_path: String
    let release_date: String
    let vote_average: Double
    
    init (id: Int, title : String, description: String, genre: Genre, poster_path: String, release_date: String, vote_average: Double) {
        self.id = id
        self.title = title
        self.description = description
        self.genre = genre
        self.post_path = "http://image.tmdb.org/t/p/w500"+poster_path
        self.release_date = release_date
        self.vote_average = vote_average
    }
    	
}
