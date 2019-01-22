# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def common_pods
  pod 'GoogleMaps'
  pod 'GooglePlaces'
end

target 'FunWithGoogleMaps' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FunWithGoogleMaps
  common_pods

  target 'FunWithGoogleMapsTests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
  end

  target 'FunWithGoogleMapsUITests' do
    inherit! :search_paths
    # Pods for testing
    common_pods
  end

end
