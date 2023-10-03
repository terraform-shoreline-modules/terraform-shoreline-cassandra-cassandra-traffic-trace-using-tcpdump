

#!/bin/bash



# Set the path to the Cassandra configuration file

CASSANDRA_CONFIG=${PATH_TO_CASSANDRA_YAML_FILE}



# Check if the configuration file exists

if [ -f $CASSANDRA_CONFIG ]; then

  echo "Cassandra configuration file found at $CASSANDRA_CONFIG"

else

  echo "Cassandra configuration file not found at $CASSANDRA_CONFIG"

  exit 1

fi



# Check if there are any syntax errors in the configuration file

CONFIG_ERRORS=$(cassandra -f -C $CASSANDRA_CONFIG 2>&1 >/dev/null | grep -i 'Error' | wc -l)



if [ $CONFIG_ERRORS -gt 0 ]; then

  echo "Cassandra configuration file has syntax errors"

  exit 1

else

  echo "Cassandra configuration file is valid"

fi



exit 0