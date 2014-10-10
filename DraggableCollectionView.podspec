Pod::Spec.new do |s|
  s.name         = 'DraggableCollectionView'
  s.version      = ‘2.0.3’
  s.summary      = 'Extension for the UICollectionView and UICollectionViewLayout that allows a user to move items with drag and drop.'
  s.homepage     = 'https://github.com/laurenwinter/DraggableCollectionView'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = [ 'Luke Scott', 'Rex Sheng', 'Lauren Winter']
  s.source       = { :git => "https://github.com/laurenwinter/DraggableCollectionView.git", :commit => '737224904cc17887bdb7652ca367d763084e5e0f' }
  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.source_files = 'DraggableCollectionView', 'DraggableCollectionView/**/*.{h,m}'
end
