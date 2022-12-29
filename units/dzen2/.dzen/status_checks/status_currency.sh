source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh


eurBuy=${euro_icon}" "$(curl -s https://klient.internetowykantor.pl/api/public/marketBrief |  jq  -c '.[] | select(.pair | contains("EUR_PLN"))' | jq .directExchangeOffers.buyNow | xargs printf "%.*f\n" 2)
gbpBuy=${euro_icon}" "$(curl -s https://klient.internetowykantor.pl/api/public/marketBrief |  jq  -c '.[] | select(.pair | contains("GBP_PLN"))' | jq .directExchangeOffers.buyNow | xargs printf "%.*f\n" 2)

eurSell=${euro_icon}" "$(curl -s https://klient.internetowykantor.pl/api/public/marketBrief |  jq  -c '.[] | select(.pair | contains("EUR_PLN"))' | jq .directExchangeOffers.sellNow | xargs printf "%.*f\n" 2)
gbpSell=${euro_icon}" "$(curl -s https://klient.internetowykantor.pl/api/public/marketBrief |  jq  -c '.[] | select(.pair | contains("GBP_PLN"))' | jq .directExchangeOffers.sellNow | xargs printf "%.*f\n" 2)




sample "currency" "${ORANGE}$eurBuy/$eurSell $gbpBuy/$gbpSell"
