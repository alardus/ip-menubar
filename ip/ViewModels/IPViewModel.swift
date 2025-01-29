import Foundation
import Network

class IPViewModel: ObservableObject {
    @Published var displayText = "Fetching IP"
    @Published var countryCode = "--"
    private var monitor: NWPathMonitor?
    private var timer: Timer?
    
    init() {
        setupNetworkMonitoring()
        Task { @MainActor in
            await fetchIP()
        }
    }
    
    private func setupNetworkMonitoring() {
        monitor = NWPathMonitor()
        monitor?.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                Task { @MainActor in
                    await self?.fetchIP()
                }
            }
        }
        monitor?.start(queue: DispatchQueue.global())
    }
    
    @MainActor
    private func fetchIP() async {
        do {
            let response = try await IPService.shared.fetchIPData()
            displayText = "\(response.ip) (\(response.details.country))"
            countryCode = response.details.countryCode
            timer?.invalidate()
            timer = nil
        } catch {
            if timer == nil {
                timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
                    Task { @MainActor in
                        await self?.fetchIP()
                    }
                }
            }
        }
    }
    
    deinit {
        monitor?.cancel()
        timer?.invalidate()
    }
} 