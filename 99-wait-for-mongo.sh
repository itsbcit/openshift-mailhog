echo $MH_MONGO_URI | while IFS=: read server port 
do
    while ! nc -z $server $port; do
      echo "waiting for $server:$port to start"
      sleep 1
    done
    echo "$server:$port has started"
done