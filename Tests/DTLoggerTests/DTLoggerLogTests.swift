import XCTest
import OSLog
@testable import DTLogger

final class DTLoggerLogTests: XCTestCase {
    var logger: DTLogger?
    
    override func setUp() {
        logger = DTLogger.shared
    }
    
    override func tearDown() {
        logger = nil
    }
    
    func test_log_withLevelInfo_shouldInfoLevel() {
        // Arrange
        let logLevel: OSLogType = .info
        
        // Act
        logger?.log(.info, "")
        
        // Assert
        XCTAssertEqual(logger?.currentLevel, logLevel)
    }
    
    func test_log_withLevelWarning_shouldWarningLevel() {
        // Arrange
        let logLevel: OSLogType = .error
        
        // Act
        logger?.log(.warning, "")
        
        // Assert
        XCTAssertEqual(logger?.currentLevel, logLevel)
    }
    
    func test_log_withLevelError_shouldErrorLevel() {
        // Arrange
        let logLevel: OSLogType = .fault
        
        // Act
        logger?.log(.error, "")
        
        // Assert
        XCTAssertEqual(logger?.currentLevel, logLevel)
    }
    
    func test_log_withLevelDebug_shouldDebugLevel() {
        // Arrange
        let logLevel: OSLogType = .debug
        
        // Act
        logger?.log(.debug, "")
        
        // Assert
        XCTAssertEqual(logger?.currentLevel, logLevel)
    }
    
    func test_log_withMessage_shouldFooMessage() {
        // Arrange
        let message = "Foo"
        
        // Act
        logger?.log(.debug, "Foo")
        
        // Assert
        XCTAssertEqual(logger?.currentMessage, message)
    }
}
