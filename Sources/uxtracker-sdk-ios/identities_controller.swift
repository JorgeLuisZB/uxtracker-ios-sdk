//
//  identities_controller.swift
//  uxtracker-sdk-ios
//
//  Created by Jorge Zaragoza on 01/09/25.
//
import Foundation

@available(iOS 16.0, *)
final class IdentitiesController {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func identifyUser(event: Event) {
        let path = "/profile/identify"
        guard let url = URL(string: path, relativeTo: Constants.URL_BASE) else {
            print("Error: Invalid URL for path \(path)")
            return
        }
        
        do {
            let payload = try JSONEncoder().encode(event)
            
            self.sendIdentify(payload: payload, to: url)
        } catch {
            print("Encoding error for batch: \(error)")
        }
    }
    
    private func sendIdentify(payload: Data, to url: URL) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = payload
        print("Sending data with \(payload)")
        session.dataTask(with: request) { _, response, error in
            if let error = error {
                print("Failed to identify user: \(error.localizedDescription)")
            } else {
                print("Successfully user identified, response: \(String(describing: response))")
            }
        }.resume()
    }
}
