require 'find_at_table'
ActionView::Base.send :include, FindAtTableHelper


unless File.exists?(RAILS_ROOT + '/public/javascripts/fiter_at_table.js')
  ['/public', '/public/javascripts'].each do |dir|
    source = File.join(directory,dir)
    dest = RAILS_ROOT + dir
    FileUtils.mkdir_p(dest)
    FileUtils.cp(Dir.glob(source+'/*.*'), dest)
  end
end
