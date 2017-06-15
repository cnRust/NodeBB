ssh root@116.62.148.227 << EOF
cd ~/NodeBB

DATE=`date +%Y-%m-%d`
git pull
docker login --username=$1 --password=$2 registry.cn-hangzhou.aliyuncs.com

# build and push to ali docker repo
docker build -t registry.cn-hangzhou.aliyuncs.com/cn_rust/nodebb .
docker push registry.cn-hangzhou.aliyuncs.com/cn_rust/nodebb

# reanem to current and restart docker-compose
docker rmi registry.cn-hangzhou.aliyuncs.com/cn_rust/nodebb:current || true
echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>> Updated docker image to 'current' tag. <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
docker tag registry.cn-hangzhou.aliyuncs.com/cn_rust/nodebb registry.cn-hangzhou.aliyuncs.com/cn_rust/nodebb:current
echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>>         DockerCompose Restarting...    <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
docker-compose up -d --build
echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>>            Redeploy Done.              <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
EOF
