#!/usr/bin/env zsh

retval=0

__reg() {
  curl -X POST -H "Content-Type:application/json" \
    -d '{"email": "me@domain.com", "password": "secret"}' \
    http://localhost:3000/api/ptusers
}

__login() {
  curl -X POST -H "Content-Type:application/json" \
    -d '{"email": "me@domain.com", "password": "secret", "ttl": 1209600000}' \
    http://localhost:3000/api/ptusers/login
}

__logout() {
  curl -X VERB -H "Authorization: $1" \
    http://localhost:3000/api/ptusers/logout
}

__count() {
  curl -X GET -H "Authorization: $1" \
    http://localhost:3000/api/ptusers/count
}

__main() {
  case "$1" in
    reg)
      __reg
      ;;
    login)
      __login
      ;;
    logout)
      echo "AuthToken: $2"
      __logout "$2"
      ;;
    count)
      echo "AuthToken: $2"
      __count "$2"
      ;;
    *)
      echo $"Usage: test.sh {reg|login|logout|count}"
      retval=1
  esac
}

__main $@

exit $retval
