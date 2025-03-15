// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DTLogger",
    platforms: [.iOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DTLogger",
            targets: ["DTLogger"])
    ],
    dependencies: [
		.package(url: "https://github.com/appmetrica/appmetrica-sdk-ios", from: "5.9.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
			name: "DTLogger",
			dependencies: [
				.product(name: "AppMetricaCore", package: "appmetrica-sdk-ios"),
				.product(name: "AppMetricaCrashes", package: "appmetrica-sdk-ios")
			]),
		.testTarget(
			name: "DTLoggerTests",
			dependencies: ["DTLogger"]),
	]
)
