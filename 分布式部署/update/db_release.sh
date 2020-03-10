###########################################
# Database script for version upgrade.
# 1. Export database data from latest server with option 'export'.
# 2. Import database data to target server with option 'import'.
############################################

# Help Msg
help="[ERROR] Invalid parameters: xxx.sh export|upgrade|rollback| dbuser dbpassword "

# Params Check
if [ $# -ne 3 ];then
	echo $help
    exit
fi

mode=$1
customerId="jsnd"
user=$2
pswd=$3
upgradeTime=`date +%Y-%m-%d`
exportDir="./${upgradeTime}/database"

if [ "$mode" == "export" ];then
	mkdir -p ${exportDir}

	# [API] Data
	mysqldump -h127.0.0.1 -u${user} -p${pswd} lfcp_api LOP_SERVICE>${exportDir}/lfcp_xxx_api.sql;
	sed -i 's/),(/),\n(/g' ${exportDir}/lfcp_xxx_api.sql

	# [WEB] Clean biz data
	# sed -i 's/USE lfcp.*/USE lfcp_'${customerId}'_web/g' ./sql/lfcp_clean_biz.sql
	# mysql -u ${user} -p${pswd} <./sql/lfcp_clean_biz.sql

	# [WEB] ACT data
	mysqldump -h127.0.0.1 -t -u${user} -p${pswd} lfcp_${customerId}_web ACT_GE_BYTEARRAY --where="(ACT_GE_BYTEARRAY.NAME_ = 'source-extra' OR ACT_GE_BYTEARRAY.NAME_ = 'source')" >${exportDir}/lfcp_xxx_web_ACT_GE_BYTEARRAY.sql;
	sed -i 's/),(/),\n(/g' ${exportDir}/lfcp_xxx_web_ACT_GE_BYTEARRAY.sql
	mysqldump -h127.0.0.1 -u${user} -p${pswd} lfcp_${customerId}_web ACT_RE_MODEL>${exportDir}/lfcp_xxx_web_ACT_RE_MODEL.sql;
	sed -i 's/),(/),\n(/g' ${exportDir}/lfcp_xxx_web_ACT_RE_MODEL.sql

	# [WEB] LFCP data
	mysqldump -h127.0.0.1 -u${user} -p${pswd} lfcp_${customerId}_web LFCP_MENU LFCP_SYSTEM_DICT LFCP_DATA_RULE LFCP_DATA_UNIT LFCP_DATA_UNIT_RULE LFCP_FORM_CONFIG LFCP_FORM_FIELD_CONFIG LFCP_FORM_FIELD_GROUP LFCP_FORM_GROUP LFCP_FORM_GROUP_FORM LFCP_FORM_GROUP_PAGE_CONFIG LFCP_FORM_GROUP_PROCESS LFCP_STATISTICS_CONFIG LFCP_STATISTICS_FIELD_CONFIG>${exportDir}/lfcp_xxx_web_LFCP.sql;
	sed -i 's/),(/),\n(/g' ${exportDir}/lfcp_xxx_web_LFCP.sql

elif [ "$mode" == "upgrade" ];then

	# import latest lfcp data;
	sed -i 's/-- Host.*/USE lfcp_'${customerId}'_api;/g' ${exportDir}/lfcp_xxx_api.sql;
	mysql -h127.0.0.1 -u ${user} -p${pswd} <${exportDir}/lfcp_xxx_api.sql;

	sed -i 's/USE lfcp.*/USE lfcp_'${customerId}'_web/g' ./sql/lfcp_clean_act.sql
	mysql -h127.0.0.1 -u ${user} -p${pswd} <./sql/lfcp_clean_act.sql
	sed -i 's/-- Host.*/USE lfcp_'${customerId}'_web;/g' ${exportDir}/lfcp_xxx_web_ACT_GE_BYTEARRAY.sql;
	mysql -h127.0.0.1 -u ${user} -p${pswd} <${exportDir}/lfcp_xxx_web_ACT_GE_BYTEARRAY.sql;

	sed -i 's/-- Host.*/USE lfcp_'${customerId}'_web;/g' ${exportDir}/lfcp_xxx_web_ACT_RE_MODEL.sql;
	mysql -h127.0.0.1 -u ${user} -p${pswd} <${exportDir}/lfcp_xxx_web_ACT_RE_MODEL.sql;

	sed -i 's/-- Host.*/USE lfcp_'${customerId}'_web;/g' ${exportDir}/lfcp_xxx_web_LFCP.sql;
	mysql -h127.0.0.1 -u ${user} -p${pswd} <${exportDir}/lfcp_xxx_web_LFCP.sql;
	

	# upgrade mysql of this time;
	upgradeFile="./sql/lfcp_${mode}.sql"
	if [ -e $upgradeFile ]; then
		sed -i 's/USE lfcp.*/USE lfcp_'${customerId}'_web;/g' ${upgradeFile};
		mysql -h127.0.0.1 -u ${user} -p${pswd} <${upgradeFile};
		echo "[INFO] Done:"${upgradeFile}
	else
		echo "[WARN] Not found:"${upgradeFile}
	fi

	# upgrade finished and set done!
	# mv "${exportDir}" "${exportDir}_done"
	
elif [ "$mode" == "rollback" ]; then
	rollbackFile="./sql/lfcp_${mode}.sql"
	if [ -e $rollbackFile ]; then
		sed -i 's/USE lfcp.*/USE lfcp_'${customerId}'_web;/g' ${rollbackFile};
		mysql -h127.0.0.1 -u ${user} -p${pswd} <${rollbackFile};
		echo "[INFO] Done:"${rollbackFile}
	else
		echo "[WARN] Not found:"${rollbackFile}
	fi

else
	echo $help
	exit
fi
