if [[ -z "$(docker-compose -v | grep 'docker-compose version')" ]]; then return; fi;

_dockerpath() {
    local dockerdir=`pwd`;
    while [[ "$dockerdir" != "/" ]];
    do
        if [ `find "$dockerdir" -maxdepth 1 -name docker-compose.yml` ];
        then echo $dockerdir; return; fi;
        dockerdir=`dirname "$dockerdir"`;
    done
    echo "";
}

_dockerdir() {
    local dockerpath=$(_dockerpath);
    echo ${dockerpath##*/};
}

_dockerproject() {
    local dockerdir=$(_dockerdir);
    echo ${dockerdir//-/};
}

function dobash() {
    if [[ $1 == "help" ]]; then
        echo '      Usage: 
        dockerbash [container = web] [user = www-data]

        dockerbash              - log into web container as www-data 
        dockerbash root         - log into web container as root 
        dockerbash mysql root   - log into mysql container as root'
        return;
    fi;
    local container=${1:-web};
    local user=${2:-owl};
    if [[ $container == "root" ]];
        then container="web"; user="root";
    fi;
    docker-compose exec -u$user $container bash;
}

_docker_run_traefik() {
    local network=${TRAEFIK_NETWORK:-web};
    local dcy="$TRAEFIK_DIR/docker-compose.yml";
    if [[ ! -f "$dcy" ]]; then echo "Set TRAEFIK_DIR to use traefik." return; fi;

    if [[ -n "$(docker network inspect $network 2>/dev/null | grep Error)" ]]; then
        echo "Creating external network $network";
        docker network create "$network";
    fi;

    if [[ -z "$(docker-compose -f $dcy ps 2>/dev/null | grep Up)" ]]; then
        echo "Starting traefik";
        docker-compose -f "$dcy" up -d;
    fi;
}

function doup() {
    _docker_run_traefik;
    docker-compose up;
}
