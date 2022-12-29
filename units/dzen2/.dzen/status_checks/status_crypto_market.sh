source $HOME/.dzen/colors.sh
source $HOME/.dzen/icons.sh
source $HOME/.dzen/utils.sh

#reportedHashrate=$(curl -s $ETHERMINE_WALLET | jq '.data.reportedHashrate' |  tr -d '\"' )



#https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=EUR

function handleCrypto(){
  reportedHashrate=$1
  currentHashrate=$2
  unit=$3
  unitDscr=$4

  reportedHashrateUnit=$(echo "$reportedHashrate/$unit" | bc)
  currentHashrateUnit=$(echo "$currentHashrate/$unit" | bc)

  diffReportedCurrent=$(( reportedHashrateUnit-currentHashrateUnit ))
  echo $diff

  if [ "$diffReportedCurrent" -gt 25 ]
  then
    colorReportedCurrent=$RED_BRIGHT
  elif [ "$diffReportedCurrent" -gt 10 ]
  then
    colorReportedCurrent=$YELLOW_BRIGHT
  else
    colorReportedCurrent=$GREEN_BRIGHT
  fi

  diffReportedReference=$(( ETH_WALLET_RATE-reportedHashrateUnit ))
  if [ "$diffReportedReference" -gt 25 ]
  then
    colorReportedReference=$RED_BRIGHT
  elif [ "$diffReportedReference" -gt 10 ]
  then
    colorReportedReference=$YELLOW_BRIGHT
  else
    colorReportedReference=$GREEN_BRIGHT
  fi


  echo ${colorReportedReference}$reportedHashrateUnit" ~ "${colorReportedCurrent}$currentHashrateUnit" "${unitDscr}${c15}


}

# initialCryptoMarker=${c15}${crypto_eth_icon}
# unit=1000000
# unitDscr="MH/s"
# #Etherminer
# reportedHashrate=$(curl -s https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=EUR | jq '.[].price_usd' |  tr -d '\"')
# currentHashrate=$(curl -s https://api.ethermine.org/miner/$ETH_WALLET/currentStats | jq '.data.currentHashrate' |  tr -d '\"' )
#
# result=$(handleCrypto $reportedHashrate $currentHashrate $unit $unitDscr)
# echo $result
# crypto=${initialCryptoMarker}${result}
# echo $crypto
#
#
# reportedHashrate=$(curl -s https://api.nanopool.org/v1/eth/reportedhashrate/$ETH_WALLET | jq '.data' )
# currentHashrate=$(curl -s https://api.nanopool.org/v1/eth/user/$ETH_WALLET | jq '.data.hashrate' )
# crypto=$crypto$(handleCrypto $reportedHashrate $currentHashrate $unit $unitDscr)
#
price=$(curl -s https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=EUR | jq '.[].price_usd' |  tr -d '\"' | cut -f1 -d".")
percent_change_1h=$(curl -s https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=EUR | jq '.[].percent_change_1h' |  tr -d '\"')
percent_change_24h=$(curl -s https://api.coinmarketcap.com/v1/ticker/ethereum/?convert=EUR | jq '.[].percent_change_24h' |  tr -d '\"')
if [[ $percent_change_1h == -* ]]; then percent_change_color1h=$RED_BRIGHT; else percent_change_color1h=$GREEN_BRIGHT; fi
if [[ $percent_change_24h == -* ]]; then percent_change_color24h=$RED_BRIGHT; else percent_change_color24h=$GREEN_BRIGHT; fi

crypto_market="${GRAY}${price}/${percent_change_color1h}${percent_change_1h}${GRAY}/${percent_change_color24h}${percent_change_24h}"
#${crypto_eth_icon}
#crypto=${c15}${crypto_eth_icon}" "${colorReportedReference}$reportedHashrateUnit" ~ "${colorReportedCurrent}$currentHashrateUnit" "${unitDscr}${c15}

sample "crypto_market" "$crypto_market"
