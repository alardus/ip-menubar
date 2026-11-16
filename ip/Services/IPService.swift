import Foundation

class IPService {
    static let shared = IPService()
    private let url = URL(string: "https://0ip.dev/api/data")!
    
    func fetchIPData() async throws -> IPResponse {
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(IPResponse.self, from: data)
    }
} 