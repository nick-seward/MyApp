#!/bin/bash

cd /home/ec2-user;
cp ./cookbooks/MyApp/codedeploy/solo.rb /home/ec2-user/;
chef-solo -c solo.rb -o MyApp;
