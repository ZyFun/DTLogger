//
//  DTLogger.swift
//
//
//  Created by Дмитрий Данилин on 24.09.2023.
//

import OSLog
import AppMetricaCrashes

/// Класс использует OSLog и считывает происходящее локально, записывая логи в единую
/// систему журналировнаия.
final public class DTLogger: @unchecked Sendable {
    /// Создаёт инстанс класса и реализует паттерн синглтон
    public static let shared = DTLogger()
    
    private init() {}
    
    /// Структура с  доступными уровнями логирования
    public enum LogLevel {
        case info
        case warning
        case error
        case debug
        
        fileprivate var prefix: String {
            switch self {
            case .info: "INFO ℹ️"
            case .warning: "WARNING ⚠️"
            case .error: "ERROR ❌"
            case .debug: "DEBUG 🩺"
            }
        }
    }
    
	internal struct LogContext {
        let file: String
        let function: String
        let line: Int
        var description: String {
            "\((file as NSString).lastPathComponent): \(line) \(function)"
        }
    }
    
    /// Метод для вывода лога в консоль
    /// - Этот метод меняет текущий уровень важности
    /// - Parameters:
    ///   - level: устанавливает уровень важности информации
    ///   - message: принимает сообщение, которое будет логироваться
    ///   - showInConsole: включает запись лога или отключает его
    ///   - shouldLogContext: включает или отключает отображение файла, функции и строки, которая была залогирована
    public func log(
        _ level: LogLevel,
        _ message: String,
		sendToMetrica: Bool = false,
        showInConsole: Bool = true,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
		let logContext = LogContext(file: file, function: function, line: line)

        if showInConsole {
            let formattedMessage = shouldLogContext
            ? "\(message)\n\n\(logContext.description)"
            : message
            
            let osLogLevel: OSLogType
            switch level {
            case .info: osLogLevel = .info
            case .warning: osLogLevel = .error
            case .error: osLogLevel = .fault
            case .debug: osLogLevel = .debug
            }
            
            guard let module = URL(fileURLWithPath: file).deletingPathExtension().pathComponents.last else { return }
            let osLog = OSLog(subsystem: module, category: level.prefix)
            
            os_log(osLogLevel, log: osLog, "%{private}@", formattedMessage)
        }

		guard sendToMetrica else { return }
		if level == .error || level == .warning  {
			sendToAppMetricaLog(message: message, with: logContext, level: level)
		}
    }

	private func sendToAppMetricaLog(message: String, with context: LogContext, level: LogLevel) {
		#if canImport(AppMetricaCrashes)
		let errorMetrica = AppMetricaError(
			identifier: "AlertLog",
			message: message,
			parameters: [
				"level": level.prefix,
				"date": Date(),
				"file": context.file,
				"function": context.function,
				"line": context.line
			],
			backtrace: Thread.callStackReturnAddresses,
			underlyingError: nil
		)
		AppMetricaCrashes.crashes().report(error: errorMetrica)
		#endif
	}
}

