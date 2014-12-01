source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


currency=$(curl -s https://internetowykantor.pl/cms/currency_money/ | jq '.rates.EUR.buying_rate' |  tr -d '\"' )

sample "currency" "$currency"
