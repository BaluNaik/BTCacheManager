import UIKit
import Foundation

public class BTCacheManager {
    
    private let cache = NSCache<NSString, UIImage>()
    private let utilityQueue = DispatchQueue.global(qos: .utility)
    public static let shared = BTCacheManager()
    
    private init() { }
    
    public var imageLimit = 75 { //default image count
        didSet {
            cache.countLimit = imageLimit
        }
    }
    public var memoryLimit = 50 * 1024 * 1024 { //Default limit to 50MB
        didSet {
            cache.totalCostLimit = memoryLimit
        }
    }
    
    public func loadImage(key: String,imageUrl: URL,saveInCache: Bool, completion: @escaping (UIImage?) -> ()) {
        utilityQueue.async {
            guard let data = try? Data(contentsOf: imageUrl) else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    public func getCachedImage(for key: NSString) -> UIImage? {
        guard let image = self.cache.object(forKey: key)  else {
            
            return nil
        }
        
        return image
    }
    
    private func saveInCacheImage(for key: NSString, image: UIImage) {
        self.cache.setObject(image, forKey: key)
    }
    
}
