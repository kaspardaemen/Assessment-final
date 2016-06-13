
import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void

enum Tab {
    case Popular
    case Theater
    case HighRated
}

class RestApiManager: NSObject {
   static let sharedInstance = RestApiManager()
    
    let baseUrl  = "http://api.themoviedb.org/3"
    
    let popular = "/discover/movie?sort_by=popularity.desc&api_key=4208b9910e5a2490a32d97c4a0df79a7&page="
    let theater = "/discover/movie?primary_release_date.gte=2014-09-15&primary_release_date.lte=2016-05-08&api_key=4208b9910e5a2490a32d97c4a0df79a7&page="
    let highRated = "/discover/movie?sort_by=vote_average.desc&vote_count.gte=200&primary_release_date.lte=1994-09-09&api_key=4208b9910e5a2490a32d97c4a0df79a7&page="
     
    
    
    func getMovies ( tab: Tab, page : Int, onCompletion: (JSON) -> Void) {
        
        var url : String
        
        switch tab {
        case Tab.Popular:
            url = baseUrl+popular
        case Tab.HighRated:
            url = baseUrl+highRated
        case Tab.Theater:
            url = baseUrl+theater
            
        }
        
        url += String(page)
        makeHTTPGetRequest(url, onCompletion: { json, err -> Void in
            onCompletion(json)
        })
    }
    
    func getTrailer ( id : Int,onCompletion: (JSON) -> Void) {
      
        let url = "http://api.themoviedb.org/3/movie/"+String(id)+"/videos?api_key=4208b9910e5a2490a32d97c4a0df79a7"
        
        makeHTTPGetRequest(url, onCompletion: { json, err -> Void in
            onCompletion(json)
        })
    }

    
    func makeHTTPGetRequest (path : String, onCompletion: ServiceResponse) {
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error in
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task.resume()
    }
    
    
}
