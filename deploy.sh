docker build -t klin7/multi-client:latest -t klin7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t klin7/multi-server:latest -t klin7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t klin7/multi-worker:latest -t klin7/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push klin7/multi-client:latest
docker push klin7/multi-client:$SHA
docker push klin7/multi-server:latest
docker push klin7/multi-server:$SHA
docker push klin7/multi-worker:latest
docker push klin7/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=klin7/multi-server:$SHA
kubectl set image deployments/client-deployment client=klin7/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=klin7/multi-worker:$SHA