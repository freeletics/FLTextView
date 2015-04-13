Pod::Spec.new do |s|
  s.name = 'FLTextView'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'UITextView + Placeholder in Swift'
  s.homepage = 'https://github.com/freeletics/FLTextView'
  s.authors = { 'Danilo Bürger' => 'danilo@freeletics.com' }
  s.source = { :git => 'https://github.com/freeletics/FLTextView.git', :tag => s.version }

  s.platform = :ios
  s.ios.framework = 'UIKit'
  s.requires_arc = true

  s.subspec 'Legacy' do |sp|
    sp.ios.deployment_target = '7.0'
    sp.preserve_paths = 'FLTextView/*.{swift,modulemap}'
  end

  s.subspec 'Default' do |sp|
    sp.ios.deployment_target = '8.0'
    sp.source_files = 'FLTextView/*.swift'
  end

  s.default_subspecs = 'Default'

end
