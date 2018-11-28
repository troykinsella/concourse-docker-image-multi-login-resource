
multi_login() {
  local other_logins=$(jq -r '.source.other_logins // []' < $payload)
  IFS=$'\n'
  for obj in $(echo "$other_logins" | jq -r '.[] | .registry+","+.username+","+.password'); do
    local reg=$(echo $obj | awk -F, '{print $1}')
    test -z "$reg" && { echo "Must supply 'registry' attribute in 'other_logins' list element" >&2; exit 1; }

    local user=${username:-$(echo $obj | awk -F, '{print $2}')}
    local pass=${password:-$(echo $obj | awk -F, '{print $3}')}

    log_in "$user" "$pass" "$reg"
  done
  unset IFS
}
