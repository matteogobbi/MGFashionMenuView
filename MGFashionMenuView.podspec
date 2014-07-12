Pod::Spec.new do |s|
  s.name         = 'MGFashionMenuView'
  s.version      = '0.0.1'
  s.summary      = 'MGFashionMenuView is a view with an awesome animation when it is shown/hidden.'
  s.homepage     = 'https://github.com/matteogobbi/MGFashionMenuView'
  s.license      = { :type => 'MIT',
                     :file => 'LICENSE' }
  s.author       = { 'Matteo Gobbi' => 'job@matteogobbi.com' }
  s.source       = { :git => 'https://github.com/matteogobbi/MGFashionMenuView.git',
                     :tag => '0.0.2' }
  s.platform     = :ios, '6.0'
  s.source_files = 'MGFashionMenuView/MGFashionMenuView.{h,m}'
  s.frameworks   = 'CoreGraphics', 'UIKit'
  s.requires_arc = true
end
