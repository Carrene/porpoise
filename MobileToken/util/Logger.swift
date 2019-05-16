import Firebase

public class Logger {


    private init() {

    }

    static let instance: Logger = {
        let instance = Logger()
        return instance
    }()

    public func log(exception: Error) {
        
    }

    public func logEvent(event: String, parameters: [String:NSObject]?) {
        
        Analytics.logEvent(event, parameters: parameters)
    }
}
