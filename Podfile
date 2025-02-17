# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'UIkitZeroToHero' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for UIkitZeroToHero
  use_frameworks!

  # Pods for CELS
  pod 'Wormholy', :configurations => ['Debug']
  pod 'Alamofire'
  pod 'SwiftKeychainWrapper'
  pod 'LanguageManager-iOS'
  pod 'Socket.IO-Client-Swift'
  pod 'Kingfisher'
  pod 'DGCharts', '~> 5.1.0'
  pod 'SwiftAlgorithms', '~> 1.0.0'
  pod 'GoogleMaps', '~> 6.2.1'
  pod 'GooglePlaces'
  pod 'Firebase/Core'
  pod 'Firebase/Messaging'
  pod 'FloatingPanel', '~> 2.8.3'
  pod 'SwiftyJSON'
  pod 'WaveSlider'

  target 'UIkitZeroToHeroTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'UIkitZeroToHeroUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.generated_projects.each do |project|
      project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
          end
      end
  end
  installer.aggregate_targets.each do |target|
    target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
    end
  end
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
        xcconfig_path = config.base_configuration_reference.real_path
        IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
    end
  end
end