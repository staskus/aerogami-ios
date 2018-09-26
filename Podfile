platform :ios, '11.0'
use_frameworks!
inhibit_all_warnings!

deployment_target = '11.0'

workspace 'TravelApplication.xcworkspace'

#Versions
$objectMapperVersion =                '~> 3.3'
$swinjectVersion =                    '~> 2.4'
$realmVersion =                       '~> 3.7'
$rxSwiftVersion =                     '~> 4.2'
$omAdditionsVersion =                 '~> 4.1'
$omRealmVersion =                     '~> 0.6'
$swiftDateVersion =                   '~> 5.0'
$moyaRxSwiftVersion =                 '~> 10.0'
$rSwiftVersion =                      '= 4.0.0'

#pod 'R.swift',                        $rSwiftVersion

# ############################################################
# TravelKit
# ############################################################

def shared_TravelKit_pods
    pod 'ObjectMapper',               $objectMapperVersion
    pod 'RealmSwift'
    pod 'RxSwift',                    $rxSwiftVersion
    pod 'ObjectMapperAdditions/Core', $omAdditionsVersion
    pod 'ObjectMapper+Realm',         $omRealmVersion
    pod 'SwiftDate',                  $swiftDateVersion
end

target 'TravelKit' do
  project 'TravelKit.xcodeproj'
  platform :ios, deployment_target

  shared_TravelKit_pods

  #target 'TravelKitTests' do
    #project 'TravelKit.xcodeproj'
  #end
end

# #############################################################################
# TravelAPIKit
# #############################################################################

def shared_TravelAPIKit_pods
    pod 'RxSwift',                        $rxSwiftVersion
    pod 'Moya/RxSwift',               $moyaRxSwiftVersion
end

target 'TravelAPIKit' do
  project 'TravelAPIKit.xcodeproj'
  platform :ios, deployment_target

  shared_TravelAPIKit_pods
end

# #############################################################################
# TravelDataKit
# #############################################################################

def shared_TravelDataKit_pods
    pod 'RealmSwift'
    pod 'RxSwift',                    $rxSwiftVersion
    pod 'SwiftDate',                  $swiftDateVersion

  shared_TravelAPIKit_pods
end

target 'TravelDataKit' do
  project 'TravelDataKit.xcodeproj'
  platform :ios, deployment_target

  shared_TravelDataKit_pods

  target 'TravelDataKitTests' do
    project 'TravelDataKit.xcodeproj'
  end
end

def shared_TravelFeatureKit_pods
    #pod 'R.swift.Library',            $rSwiftVersion
    pod 'Swinject',                   $swinjectVersion
  
  shared_TravelDataKit_pods
end

# #############################################################################
# Application
# #############################################################################

def shared_Apps_pods
  shared_TravelFeatureKit_pods
end

target 'TravelApplication' do
    project 'TravelApplication.xcodeproj'
    platform :ios, deployment_target
    shared_Apps_pods
end

# #############################################################################
# Customisation
# #############################################################################

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'YES'

            if config.name == 'Debug'
              config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
              config.build_settings['OTHER_SWIFT_FLAGS'] = ['$(inherited)', '-Onone']
              config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            else
              config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf-with-dsym'
              config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end

            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end
end