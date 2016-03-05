check_var() {
  if [[ ! -v $1 || -z $(eval echo \$${1}) ]]; then
    echo "Missing environment variable $1 : $2"
    ((++badVars))
  fi
}

resolve_vars() {
    if [[ $badVars > 0 ]]; then
      echo "
There were one or more missing build variables"
      exit 1
    fi
}
