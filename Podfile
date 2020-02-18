# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Pokedex' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Pokedex

  def testing_pods 
  	pod 'Quick'
  	pod 'Nimble'
  	pod 'Swinject'
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




end
