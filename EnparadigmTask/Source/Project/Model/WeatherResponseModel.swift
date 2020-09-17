//
//  WeatherResponseModel.swift
//  EnparadigmTask
//
//  Created by mobiotics1067 on 17/09/20.
//  Copyright © 2020 mobiotics1067. All rights reserved.
//

import Foundation

// MARK: - WeatherMOdel
class WeatherModel: Codable {
    var coord: Coord?
    var weather: [Weather]?
    var base: String?
    var main: Main?
    var visibility: Int?
    var wind: Wind?
    var clouds: Clouds?
    var dt: Int?
    var sys: Sys?
    var timezone, id: Int?
    var name: String?
    var cod: Int?
    enum RegisterCodingKeys : String, CodingKey{
        case coord = "coord"
        case weather = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case dt = "dt"
        case sys = "sys"
        case timezone = "timezone"
        case id = "id"
        case name = "name"
        case cod = "cod"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RegisterCodingKeys.self)
        coord = try (container.decodeIfPresent(Coord.self, forKey: .coord))
        weather = try? (container.decodeIfPresent([Weather].self, forKey: .weather))
        base = try container.decodeIfPresent(String.self, forKey: .base)
        main = try container.decodeIfPresent(Main.self, forKey: .main)
        visibility = try container.decodeIfPresent(Int.self, forKey: .visibility)
        wind = try container.decodeIfPresent(Wind.self, forKey: .wind)
        clouds = try container.decodeIfPresent(Clouds.self, forKey: .clouds)
        dt = try container.decodeIfPresent(Int.self, forKey: .dt)
        sys = try container.decodeIfPresent(Sys.self, forKey: .sys)
        timezone = try container.decodeIfPresent(Int.self, forKey: .timezone)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        cod = try container.decodeIfPresent(Int.self, forKey: .cod)
    }
}

// MARK: - Clouds
class Clouds: Codable {
    var all: Int?
    enum RegisterCodingKeys : String, CodingKey{
        case all = "all"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RegisterCodingKeys.self)
        all = try (container.decodeIfPresent(Int.self, forKey: .all))
    }
    
}
// MARK: - Coord
class Coord: Codable {
    var lon, lat: Double?
    enum RegisterCodingKeys : String, CodingKey{
        case lon = "lon"
        case lat = "lat"
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RegisterCodingKeys.self)
        lon = try (container.decodeIfPresent(Double.self, forKey: .lon))
        lat = try (container.decodeIfPresent(Double.self, forKey: .lat))
    }
}

// MARK: - Main
class Main: Codable {
    var temp, feelsLike, tempMin, tempMax: Double?
    var pressure, humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure, humidity
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temp = try (container.decodeIfPresent(Double.self, forKey: .temp))
        feelsLike = try (container.decodeIfPresent(Double.self, forKey: .feelsLike))
        tempMin = try (container.decodeIfPresent(Double.self, forKey: .tempMin))
        tempMax = try (container.decodeIfPresent(Double.self, forKey: .tempMax))
        pressure = try (container.decodeIfPresent(Int.self, forKey: .pressure))
        humidity = try (container.decodeIfPresent(Int.self, forKey: .humidity))
    }
}

// MARK: - Sys
class Sys: Codable {
    var type, id: Int?
    var country: String?
    var sunrise, sunset: Int?
    enum CodingKeys: String, CodingKey {
        case type, id, sunrise, sunset
        case country
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try (container.decodeIfPresent(Int.self, forKey: .id))
        type = try (container.decodeIfPresent(Int.self, forKey: .type))
        country = try (container.decodeIfPresent(String.self, forKey: .country))
        sunrise = try (container.decodeIfPresent(Int.self, forKey: .sunrise))
        sunset = try (container.decodeIfPresent(Int.self, forKey: .sunset))
    }
    
}

// MARK: - Weather
class Weather: Codable {
    var id: Int?
    var main, weatherDescription, icon: String?
    
    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try (container.decodeIfPresent(Int.self, forKey: .id))
        main = try (container.decodeIfPresent(String.self, forKey: .main))
        weatherDescription = try (container.decodeIfPresent(String.self, forKey: .weatherDescription))
        icon = try (container.decodeIfPresent(String.self, forKey: .icon))
    }
}

// MARK: - Wind
class Wind: Codable {
    var speed: Double?
    var deg: Int?
    enum CodingKeys: String, CodingKey {
        case speed
        case deg 
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try (container.decodeIfPresent(Double.self, forKey: .speed))
        deg = try (container.decodeIfPresent(Int.self, forKey: .deg))
    }
}
