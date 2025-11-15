# Use the official AWS Lambda adapter image to handle the Lambda runtime
FROM public.ecr.aws/awsguru/aws-lambda-adapter:0.9.0 AS aws-lambda-adapter


FROM oven/bun:debian AS bun_latest

# Copy the Lambda adapter into the container
COPY --from=aws-lambda-adapter /lambda-adapter /opt/extensions/lambda-adapter

# Set the port to 8080. This is required for the AWS Lambda adapter.
ENV PORT=8080

# Set the work directory to `/var/task`. This is the default work directory for Lambda.
WORKDIR "/var/task"

COPY ./../package.json ./package.json
COPY ./../bun.lock ./bun.lock

RUN bun install --production --frozen-lockfile

COPY ./../src/ /var/task
