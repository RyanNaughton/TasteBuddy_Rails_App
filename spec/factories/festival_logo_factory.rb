Factory.define :festival_logo, class: 'Festival::Logo' do |f|
  f.low_resolution 'http://example.com/low.jpg'
  f.standard_resolution 'http://example.com/std.jpg'
end
