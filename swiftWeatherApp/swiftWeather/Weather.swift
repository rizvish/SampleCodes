import UIKit
import CoreLocation

struct Weather {
    let summary:String
    let icon:String
    let temperatureMin:Int
    let windSpeed:Double
    let temperature:Int
    let dewPoint: Double
    let humidity: Double
    let cloudCover: Double

    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let temperature = json["temperatureMax"] as? Int else {throw SerializationError.missing("temp is missing")}
        
       guard let temperatureMin = json["temperatureMin"] as? Int else {throw SerializationError.missing("icon is missing")}

        guard let dewPoint = json["dewPoint"] as? Double else {throw SerializationError.missing("summary is missing")}
        guard let humidity = json["humidity"] as? Double else {throw SerializationError.missing("humidity is missing")}
        guard let cloudCover = json["cloudCover"] as? Double else {throw SerializationError.missing("cloudCover is missing")}
        
        guard let windSpeed = json["windSpeed"] as? Double else {throw SerializationError.missing("windSpeed is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.temperatureMin = temperatureMin
        self.windSpeed = windSpeed
        self.dewPoint = dewPoint
        self.humidity = humidity
        self.cloudCover = cloudCover

        
    }

   static let basePath = "https://api.darksky.net/forecast/3bdf367c37b529a83ceee7d8d725a1e7/"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
                
            }
            
            
        }
        
        task.resume()
    }
}

