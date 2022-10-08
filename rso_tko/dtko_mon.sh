#!/bin/bash

############
# env
############

SCRIPT_DIR=`pwd`
DATE_STAMP=`date +%F`
DB_NAME="hcsagrdb"
DB_USER="postgres"
DB_ADDRESS="127.0.0.1"
DB_PORT="5454"

############
# dtko env
############

RAW_DTKO_COUNT=`psql -p ${DB_PORT} -h ${DB_ADDRESS} -U ${DB_USER} -d ${DB_NAME} \
	-c "select
		count(*)
	from
		agrsm.agr_tko_documents
	where
		last_editing_date > (now()- interval '4 day')
		and last_editing_date < (now()- interval '3 day')
		and rao_call_status != 'SUCCESS'
		and status = 'RUNNING'
		and actual_by_business;" \
	| grep -e '[0-9]' \
	| head -n 1`
DTKO_COUNT=`echo $(($RAW_DTKO_COUNT))`

DTKO_GUIDS=`psql -p ${DB_PORT} -h ${DB_ADDRESS} -U ${DB_USER} -d ${DB_NAME} \
	-o ${SCRIPT_DIR}/DTKO_${DATE_STAMP}.csv \
	-c "select
		root_guid
	from
		agrsm.agr_tko_documents
	where
		last_editing_date > (now()- interval '4 day')
		and last_editing_date < (now()- interval '3 day')
		and rao_call_status != 'SUCCESS'
		and status = 'RUNNING'
		and actual_by_business;"`

############
# drso env
############

RAW_DRSO_COUNT=`psql -p ${DB_PORT} -h ${DB_ADDRESS} -U ${DB_USER} -d ${DB_NAME} \
	-c "select
		count(*)
	from
		agrsm.agr_rso_documents
	where
		last_editing_date > (now()- interval '4 day')
		and last_editing_date < (now()- interval '3 day')
		and rao_call_status != 'SUCCESS'
		and status = 'RUNNING'
		and actual_by_business;" \
	| grep -e '[0-9]' \
	| head -n 1`

DRSO_COUNT=`echo $(($RAW_DRSO_COUNT))`

DRSO_GUIDS=`psql -p ${DB_PORT} -h ${DB_ADDRESS} -U ${DB_USER} -d ${DB_NAME} \
	-o ${SCRIPT_DIR}/DRSO_${DATE_STAMP}.csv \
	-c "select
		root_guid
	from
		agrsm.agr_rso_documents
	where
		last_editing_date > (now()- interval '4 day')
		and last_editing_date < (now()- interval '3 day')
		and rao_call_status != 'SUCCESS'
		and status = 'RUNNING'
		and actual_by_business;"`
`
