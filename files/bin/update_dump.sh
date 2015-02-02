#/bin/bash

LOCAL_DAILY_BK="$1".`date +%Y-%m-%d`
cp "$1" $LOCAL_DAILY_BK

DEV_HOST="$2"

if [ -z "$2" ] 
   then
	DEV_HOST="localtest.extole.com"
fi

echo "substituting extole host name with $DEV_HOST" 

sed -i "s/www.extole.com/$DEV_HOST/g" $LOCAL_DAILY_BK

echo "Done."

