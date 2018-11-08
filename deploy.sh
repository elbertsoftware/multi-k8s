docker build -t kennethdocker/multi-client:latest -t kennethdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kennethdocker/multi-server:latest -t kennethdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kennethdocker/multi-worker:latest -t kennethdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kennethdocker/multi-client:latest
docker push kennethdocker/multi-server:latest
docker push kennethdocker/multi-worker:latest

docker push kennethdocker/multi-client:$SHA
docker push kennethdocker/multi-server:$SHA
docker push kennethdocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kennethdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=kennethdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kennethdocker/multi-worker:$SHA