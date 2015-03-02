# User account required for hosting the source code
# Note: The default user is barun -- if you change this, you need to
# manually update the settings.py file
USER=barun
useradd -m "$USER"

HOME_PATH=/home/"$USER"
SE_PATH=$HOME_PATH/codes/python/django/nb/ISAD/src/vlabs
CUR_PATH=$(pwd)

# Directories where intermediate files would be created
mkdir -p /var/vlabs/isad/uml/img
mkdir -p /var/vlabs/isad/cfg
mkdir -p /var/vlabs/isad/uploads/image_uploads
chown -R www-data /var/vlabs

#mv ../codes /home/barun/codes
mv ../codes "$HOME_PATH"/codes
cp ../conf/httpd.conf /etc/apache2/
mv ../conf/www /usr/local/

# Initialize the database
# Note: You must have the following two SQL files available
mysql -u root < cse08-se_init.sql
mysql -u root db_isad < cse08-se_db.sql

# Create symlinks
#ln -s /var/vlabs/isad/ /home/barun/codes/python/django/nb/ISAD/src/vlabs/media/isad_erd
ln -s /var/vlabs/isad/ "$SE_PATH"/media/isad_erd
#ln -s /var/vlabs/isad/uploads /home/barun/codes/python/django/nb/ISAD/src/vlabs/media/uploads
ln -s /var/vlabs/isad/uploads "$SE_PATH"/media/uploads
#ln -s /var/vlabs/ /home/barun/codes/python/django/nb/ISAD/src/vlabs/media/vlabs
ln -s /var/vlabs/ "$SE_PATH"/media/vlabs

# Generate the secret key
cd "$SE_PATH" && python utils/generate_secret_key.py
cd "$CUR_PATH"
