# justfile

default:
    @echo "Specify a recipe to run"

status:
    docker ps --format "table {{'{{'}}.Names{{'}}'}}\t{{'{{'}}.Status{{'}}'}}\t{{'{{'}}.Ports{{'}}'}}" | grep -E "^NAMES|homelab" || docker ps