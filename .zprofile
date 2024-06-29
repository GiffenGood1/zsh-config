
if [[ "$OSTYPE" == "darwin"* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"

############################# Linux specific configuration #############################
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux specific configuration goes here
  
fi