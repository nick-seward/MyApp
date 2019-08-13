default_action :install

action :install do
    ec2_meta_data_url   = "http://169.254.169.254/latest/meta-data/"
    ec2_public_ip_url   = ec2_meta_data_url + "public-ipv4"
    ec2_private_ip_url  = ec2_meta_data_url + "local-ipv4"
    public_ip           = " --- "
    private_ip          = " --- "

    # Get the public and private ip addresses from AWS
    begin
        http_call = Chef::HTTP.new(ec2_public_ip_url)
        public_ip = http_call.request('get', http_call.url)
    rescue
    end
        
    begin
        http_call = Chef::HTTP.new(ec2_private_ip_url)
        private_ip = http_call.request('get', http_call.url)
    rescue 
    end

    template '/usr/share/nginx/html/index.html' do
        source 'index.html.erb'
        variables(
            publicip: public_ip,
            privateip: private_ip
        )
        owner 'root'
        group 'root'
        mode '0644'
        action :create
    end

    service 'nginx' do
        action :restart
    end
end
