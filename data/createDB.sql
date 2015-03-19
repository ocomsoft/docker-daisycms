CREATE DATABASE daisyrepository CHARACTER SET 'utf8';
GRANT ALL ON daisyrepository.* TO daisy@'%' IDENTIFIED BY 'daisy';
GRANT ALL ON daisyrepository.* TO daisy@localhost IDENTIFIED BY 'daisy';
CREATE DATABASE activemq CHARACTER SET 'utf8';
GRANT ALL ON activemq.* TO activemq@'%' IDENTIFIED BY 'activemq';
GRANT ALL ON activemq.* TO activemq@localhost IDENTIFIED BY 'activemq';
