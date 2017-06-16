ssh root@116.62.148.227 << EOF
cd ~/NodeBB

git checkout master
git pull

# build rew image
docker build -t rustbb .

echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>>         DockerCompose Restarting...    <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
OSS_UPLOADS_BUCKET=cnrust OSS_UPLOADS_HOST=https://cdn.cnrust.org OSS_UPLOADS_PATH=/assets OSS_DEFAULT_REGION=oss-cn-hangzhou docker-compose up -d --no-deps --build
echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>>           Clean up images.             <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
docker rmi $(docker images --filter "dangling=true" -q --no-trunc)
echo "====================================cnRust======================================"
echo ">>>>>>>>>>>>>>>>>>>>            Redeploy Done.              <<<<<<<<<<<<<<<<<<<<"
echo "================================================================================"
EOF
