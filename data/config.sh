#!/bin/bash
export DAISY_HOME=/daisy/daisy-2.4.2
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-oracle-x64

sed -i '/skip-external-locking/a lower_case_table_names = 1' /etc/mysql/my.cnf

/usr/bin/mysqld_safe &
sleep 10s

#/usr/bin/mysql -uroot < /daisy/setup/createDB.sql
mysqladmin -u root create daisyrepository
mysqladmin -u root create activemq
mysql -u root daisyrepository -e "grant all on daisyrepository.* to daisy@'%' identified by 'daisy'"
mysql -u root daisyrepository -e "grant all on daisyrepository.* to daisy@'localhost' identified by 'daisy'"
mysql -u root daisyrepository -e "grant all on activemq.* to activemq@'%' identified by 'activemq'"
mysql -u root daisyrepository -e "grant all on activemq.* to activemq@'localhost' identified by 'activemq'"

rm -r -f /daisy/daisy-2.4.2/wrapper/  # clean up Wrapper -not used
mkdir -p /daisy/repo
mkdir -p /daisy/wiki

$DAISY_HOME/install/daisy-repository-init -i /daisy/setup/install.properties
sed -i -e "s/org.hibernate.dialect.MySQLInnoDBDialect/org.hibernate.dialect.MySQL5InnoDBDialect/g"  /daisy/repo/conf/myconfig.xml

echo Starting Repo
$DAISY_HOME/repository-server/bin/daisy-repository-server /daisy/repo &
sleep 30s

$DAISY_HOME/install/daisy-wiki-init -c /daisy/setup/daisy-autoinst.properties
$DAISY_HOME/install/daisy-wikidata-init -d /daisy/wiki -c /daisy/setup/daisy-autoinst.properties
$DAISY_HOME/install/daisy-wiki-add-site -c /daisy/setup/daisy-autoinst.properties
$DAISY_HOME/daisywiki/bin/daisy-wiki /daisy/wiki &
