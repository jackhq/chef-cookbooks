directory node[:dir] do
  action :create
  owner node[:owner] if node[:owner]
  group node[:group] if node[:group]
  not_if "test -d #{node[:dir]}"
end

template "#{node[:dir]}/solo.rb" do
  source "solo.rb.erb"
  owner node[:owner] if node[:owner]
  group node[:group] if node[:group]
  not_if do
    File.exists?("#{node[:dir]}/solo.rb")
  end
end

template "#{node[:dir]}/Rakefile" do
  source "Rakefile.erb"
  owner node[:owner] if node[:owner]
  group node[:group] if node[:group]
  not_if do
    File.exists?("#{node[:dir]}/Rakefile")
  end
end


%w{ site-cookbooks dna }.each do |sub_dir|
  directory "#{node[:dir]}/#{sub_dir}" do
    action :create
    owner node[:owner] if node[:owner]
    group node[:group] if node[:group]
    not_if "test -d #{node[:dir]}/#{sub_dir}"
  end
end

# Get Cookbooks from Ops code