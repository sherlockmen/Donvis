// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CodeQuota",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "CodeQuota", targets: ["CodeQuota"])
    ],
    targets: [
        .executableTarget(
            name: "CodeQuota",
            resources: [.copy("Resources/AppIcon.icns"), .copy("Resources/MenuBarIcons")],
            linkerSettings: [
                .linkedFramework("AppKit"),
                .linkedFramework("Security"),
                .linkedFramework("ServiceManagement"),
                .linkedFramework("UserNotifications")
            ]
        ),
        .testTarget(name: "CodeQuotaTests", dependencies: ["CodeQuota"])
    ]
)
