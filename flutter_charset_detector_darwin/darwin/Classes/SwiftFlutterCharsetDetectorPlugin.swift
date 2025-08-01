#if os(iOS)
    import Flutter
#elseif os(macOS)
    import FlutterMacOS
#endif
import UniversalDetector2

public class SwiftFlutterCharsetDetectorPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        #if os(iOS)
            let messenger = registrar.messenger()
        #else
            let messenger = registrar.messenger
        #endif
        let taskQueue: FlutterTaskQueue? = nil  // Background task queue not supported in all Flutter versions
        let channel = FlutterMethodChannel(name: "flutter_charset_detector", binaryMessenger: messenger, codec: FlutterStandardMethodCodec.sharedInstance(), taskQueue: taskQueue)
        let instance = SwiftFlutterCharsetDetectorPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let result = { (val: Any?) in
            DispatchQueue.main.async { result(val) }
        }
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            switch call.method {
            case "autoDecode":
                handleAutoDecode(call, result)
            case "detect":
                handleDetect(call, result)
            default:
                result(FlutterError(code: "UnsupportedMethod", message: "\(call.method) is not supported", details: nil))
            }
        }
    }

    func handleAutoDecode(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String:Any?] else {
            result(FlutterError(code: "MissingArgs", message: "Required arguments missing", details: "\(call.method) requires 'data'"))
            return
        }
        guard let data = args["data"] as? FlutterStandardTypedData else {
            result(FlutterError(code: "MissingArg", message: "Required argument missing", details: "\(call.method) requires 'data'"))
            return
        }
        // Elsewhere in the plugin we use the term "charset" instead of
        // "encoding", but for consistency with iOS APIs we use the term in a
        // limited capacity here
        guard let encodingName = UniversalDetector.encodingAsString(with: data.data) else {
            result(FlutterError(code: "DetectionFailed", message: "The charset could not be detected", details: nil))
            return
        }
        let encoding = CFStringConvertIANACharSetNameToEncoding(encodingName as CFString)
        guard encoding != kCFStringEncodingInvalidId else {
            result(FlutterError(code: "UnsupportedCharset", message: "The detected charset \(encodingName) is not supported.", details: nil))
            return
        }
        let nsEncoding = CFStringConvertEncodingToNSStringEncoding(encoding)
        guard let decoded = NSString(data: data.data, encoding: nsEncoding) else {
            result(FlutterError(code: "DecodingFailed", message: "The data could not be decoded", details: "Detected charset: \(encodingName)"))
            return
        }
        result([
            "charset": encodingName,
            "string": decoded
        ])
    }

    func handleDetect(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String:Any?] else {
            result(FlutterError(code: "MissingArgs", message: "Required arguments missing", details: "\(call.method) requires 'data'"))
            return
        }
        guard let data = args["data"] as? FlutterStandardTypedData else {
            result(FlutterError(code: "MissingArg", message: "Required argument missing", details: "\(call.method) requires 'data'"))
            return
        }
        // Elsewhere in the plugin we use the term "charset" instead of
        // "encoding", but for consistency with iOS APIs we use the term in a
        // limited capacity here
        guard let encodingName = UniversalDetector.encodingAsString(with: data.data) else {
            result(FlutterError(code: "DetectionFailed", message: "The charset could not be detected", details: nil))
            return
        }
        result(encodingName);
    }
}
