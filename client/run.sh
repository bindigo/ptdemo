#!/usr/bin/env zsh
prog=$0

python=$(which python2.7)
node=$(which node)
npm=$(which npm)

__install() {
  ${npm} install http-server -s
}

__run_python() {
  ${python} -m SimpleHTTPServer 8888
}

__run_node() {
  node_modules/http-server/bin/http-server -p 8888 .
}

__main() {
  case "$1" in
    install)
        __install
        ;;
    node)
        __run_node
        ;;
    python)
        __run_python
        ;;
    *)
        echo $"Usage: $prog {install|node|python}"
        exit 1
  esac

  exit 0
}

__main $@
