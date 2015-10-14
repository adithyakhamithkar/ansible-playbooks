#/bin/bash
TARGET=$1
DATABASE=$2
DESTINATION=$3
echo "Starting...To dump database("$DATABASE")"
ansible-playbook -i inventory/hosts mysql-dump.yml -e "inventory="$TARGET" database_name="$DATABASE"" -vvvv
echo "Transfering the database("$DATABASE") to "$DESTINATION""
ansible-playbook -i inventory/hosts mysql-transfer-db.yml -e "inventory="$TARGET" database_name="$DATABASE" target_host="$DESTINATION"" -vvvv
echo "Importing the database("$DATABASE")"
ansible-playbook -i inventory/hosts mysql-import.yml -e "inventory="$DESTINATION" database_name="$DATABASE"" -vvvv
exit
