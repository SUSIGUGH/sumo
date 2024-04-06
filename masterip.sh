v1=`cd linkedtoworld/terraform && terraform output | grep "masterpubip" | head -1 | cut -d"=" -f2`
echo $v1
