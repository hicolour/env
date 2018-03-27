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


  echo "${colorReportedReference}${reportedHashrateUnit}~${colorReportedCurrent}${currentHashrateUnit}${unitDscr}${c15}"


}

initialCryptoMarker="${WHITE}${crypto_eth_icon}"
#${c15}${crypto_eth_icon}
unit=1000000
unitDscr="MH/s"
#Etherminer
reportedHashrate=$(curl -s https://api.ethermine.org/miner/$ETH_WALLET/currentStats | jq '.data.reportedHashrate' |  tr -d '\"' )
currentHashrate=$(curl -s https://api.ethermine.org/miner/$ETH_WALLET/currentStats | jq '.data.currentHashrate' |  tr -d '\"' )

result=$(handleCrypto $reportedHashrate $currentHashrate $unit $unitDscr)

crypto="${c15}${initialCryptoMarker}${result}"

#
#
# reportedHashrate=$(curl -s https://api.nanopool.org/v1/eth/reportedhashrate/$ETH_WALLET | jq '.data' )
# currentHashrate=$(curl -s https://api.nanopool.org/v1/eth/user/$ETH_WALLET | jq '.data.hashrate' )
# crypto=$crypto$(handleCrypto $reportedHashrate $currentHashrate $unit $unitDscr)
#


#crypto=${c15}${crypto_eth_icon}" "${colorReportedReference}$reportedHashrateUnit" ~ "${colorReportedCurrent}$currentHashrateUnit" "${unitDscr}${c15}

sample "crypto_miner" "$crypto"
