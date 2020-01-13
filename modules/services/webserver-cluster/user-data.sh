#!/bin/bash

cat > index.html <<EOF
<html>
<body>
<h1>hola, mundo! Now, using modules!</h1>
<p>DB address: ${db_host}:${db_port}</p>
</body>
</html>
EOF

nohup busybox httpd -f -p ${server_port} &