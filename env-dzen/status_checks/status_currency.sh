source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


currency=${euro_icon}" "$(curl -s https://internetowykantor.pl/cms/currency_money/ | jq '.rates.EUR.buying_rate' |  tr -d '\"' | xargs printf "%.*f\n" 2)
echo $currency
sample "currency" "${GRAY}$currency"
