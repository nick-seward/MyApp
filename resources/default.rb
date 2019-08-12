default_action :install

action :install do
    public_ip = "public"
    private_ip = "private"

    # Get the ip addresses from AWS

    template '/var/www/html/index.html' do
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
end
