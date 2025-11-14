$ecr = "931168083238.dkr.ecr.us-east-2.amazonaws.com"

$password = aws ecr get-login-password --region us-east-2;

docker login --username AWS -p $password $ecr

docker-compose -f ./docker-compose.yaml build

docker tag bun-lambda_bun-lambda "$ecr/bun-lambda-image:latest"
docker push "$ecr/bun-lambda-image:latest"