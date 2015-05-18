# Function definitions
error() {
  echo " !     $*" >&2
  exit 1
}

status() {
  echo "-----> $*"
}

# sed -l basically makes sed replace and buffer through stdin to stdout
# so you get updates while the command runs and dont wait for the end
# e.g. npm install | indent
indent() {
  c='s/^/       /'
  case $(uname) in
    Darwin) sed -l "$c";; # mac/bsd sed: -l buffers on line boundaries
    *)      sed -u "$c";; # unix/gnu sed: -u unbuffered (arbitrary) chunks of data
  esac
}

export_env_dir() {
  env_dir=$1
  whitelist_regex=${2:-''}
  blacklist_regex=${3:-'^(PATH|GIT_DIR|CPATH|CPPATH|LD_PRELOAD|LIBRARY_PATH)$'}

  if [ -d "$env_dir" ]; then
    # Write opening brace
    echo { >> env.json

    # Loop through each environment variable
    for e in $(ls $env_dir); do
      # echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      # export "$e=$(cat $env_dir/$e)"
      # :
      echo "$e" | grep -E "$whitelist_regex" | grep -qvE "$blacklist_regex" &&
      echo \"$e\": \"$(cat $env_dir/$e)\", >> env.json
    done

    # Remove final comma
    case $(uname) in
      Darwin) sed -i '' '$s/.$//' env.json;; # mac/bsd sed: -i requires extension
      *)      sed -i '$s/.$//' env.json;; # unix/gnu sed: -i does not require extension
    esac

    # Write closing brace
    echo } >> env.json
  fi
}