import Foundation

struct IPResponse: Decodable {
    let ip: String
    let details: IPDetails
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        ip = try container.decode(String.self)
        details = try container.decode(IPDetails.self)
    }
}

struct IPDetails: Decodable {
    let country: String
    
    var countryCode: String {
        let countryMapping: [String: String] = [
            "The Netherlands": "NL",
            "Russia": "RU",
            "Germany": "DE",
            "United States": "US",
            "United Kingdom": "GB",
            "France": "FR",
            "Spain": "ES",
            "Italy": "IT",
            "China": "CN",
            "Japan": "JP",
            "South Korea": "KR",
            "Canada": "CA",
            "Brazil": "BR",
            "Australia": "AU",
            "India": "IN",
            "Sweden": "SE",
            "Norway": "NO",
            "Finland": "FI",
            "Denmark": "DK",
            "Poland": "PL",
            "Ukraine": "UA",
            "Switzerland": "CH",
            "Austria": "AT",
            "Belgium": "BE",
            "Ireland": "IE",
            "Portugal": "PT",
            "Greece": "GR",
            "Turkey": "TR",
            "Israel": "IL",
            "Singapore": "SG"
        ]
        
        return countryMapping[country] ?? "??"
    }
} 