



get_aws_hostname(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/hostname
}

get_aws_instance_id(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/instance-id
}

get_aws_availability_zone(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/placement/availability-zone/
}

get_aws_public_hostname(){
    local page="$(curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/public-hostname)"
    local line_count=$(echo "$page" | wc -l)
    if [ $line_count -eq 1 ];
        then
            echo "${page}"
        else
            echo ""
    fi
}

get_aws_public_ipv4(){
    local page="$(curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/public-ipv4)"
    local line_count=$(echo "$page" | wc -l)
    if [ $line_count -eq 1 ];
        then
            echo "${page}"
        else
            echo ""
    fi
}

get_aws_ipv4(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/placement/local-ipv4
}

get_aws_mac(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/mac
}

get_aws_vpc_id(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(get_aws_mac)/vpc-id
}

get_aws_subnet_id(){
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/network/interfaces/macs/$(get_aws_mac)/subnet-id
}

get_aws_billing_account(){
    #curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/dynamic/instance-identity/document | grep '"accountId" :'
    # https://stackoverflow.com/questions/1955505/parsing-json-with-unix-tools
    # python2
    curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/dynamic/instance-identity/document | \
        python -c "import sys, json; print json.load(sys.stdin)['accountId']"
        # python 3
        # python3 -c "import sys, json; print(json.load(sys.stdin)['name'])"
}


has_aws_multiple_macs(){
    local cnt=$(curl --silent -c 0.1 -m .2 http://169.254.169.254/latest/meta-data/network/interfaces/macs/ | wc -l )
    if [ $cnt -eq 1 ];
        then
            echo 0
        else
            echo 1
    fi
}

is_aws(){

    local aws_hostname="$(get_aws_hostname)"
    if [[ $aws_hostname = "" ]]; 
        then
            echo "0"
        else
            echo "1"
    fi
    
}


get_aws_prompt_line(){
    if [ $(is_aws) -eq 1 ];
        then
            local C_AWS_1="$(tput setaf 172)"
            local C_AWS_2="$(tput setaf 202)"
            if [ "$(get_aws_public_ipv4)" != "" ];
                then
                    local aws_pub="${CB}:${C_AWS_1}$(get_aws_public_ipv4)${CB}:${C_AWS_2}$(get_aws_public_hostname)"
            fi

            local aws_prompt_line="
$( make_line_data "${C_AWS_1}$(get_aws_billing_account)${CB}:${C_AWS_2}$(get_aws_availability_zone)${CB}:${C_AWS_1}$(get_aws_vpc_id)${CB}:${C_AWS_2}$(get_aws_subnet_id)" ${COLUMNS} )${aws_pub}"
    fi
    echo "${aws_prompt_line}"
}
