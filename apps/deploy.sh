REPOSITORY="" # Update from ouput ecr_repository_urls.api
ENV="dev"
REGION="us-east-2" # Update your region
PROFILE="aws-terrajet-${ENV}"

# Deploy frontend
S3="s3://terrajet-${ENV}-static-web-app"
aws s3 cp --profile $PROFILE --region $REGION ./frontend/* $S3

# Deploy backend
AWS_ECS_SERVICE=api-service
ECS_CLUSTER="TERRAJET-$(echo $ENV | tr '[:lower:]' '[:upper:]')-ECS"
aws ecr get-login-password --profile $PROFILE --region $REGION | docker login --username AWS --password-stdin $REPOSITORY
docker build --platform=linux/amd64 -f backend-api/Dockerfile -t $REPOSITORY .
docker push $REPOSITORY
aws ecs update-service --profile $PROFILE --region $REGION --service $AWS_ECS_SERVICE --cluster $ECS_CLUSTER --force-new-deployment --no-cli-pager
