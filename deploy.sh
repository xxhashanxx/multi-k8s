docker build -t xxhashanxx/multi-client:latest -t xxhashanxx/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t xxhashanxx/multi-server:latest -t xxhashanxx/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t xxhashanxx/multi-worker:latest -t xxhashanxx/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push xxhashanxx/multi-client:latest
docker push xxhashanxx/multi-server:latest
docker push xxhashanxx/multi-worker:latest

docker push xxhashanxx/multi-client:$SHA
docker push xxhashanxx/multi-server:$SHA
docker push xxhashanxx/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=xxhashanxx/multi-server:$SHA
kubectl set image deployments/client-deployment client=xxhashanxx/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=xxhashanxx/multi-worker:$SHAxxhashanxx