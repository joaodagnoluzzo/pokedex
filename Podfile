# Uncomment the next line to define a global platform for your project
platform :ios, '13.2'

target 'Pokedex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pokedex

  def testing_pods 
  	pod 'Quick'
  	pod 'Nimble'
  end

  def ui_testing_pods
    pod 'Quick'
    pod 'Nimble'
  end

  target 'PokedexTests' do
    inherit! :search_paths
    # Pods for testing
	testing_pods
  end

  target 'PokedexUITests' do
    # Pods for UI testing
    ui_testing_pods
  end

  post_install do |installer|
      installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.2'
              end
          end
      end
  end

end
