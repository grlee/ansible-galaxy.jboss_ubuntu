### BEGIN INIT INFO
# Provides:          jboss
# Required-Start:    $local_fs $remote_fs $network $syslog
# Required-Stop:     $local_fs $remote_fs $network $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start/Stop JBoss
### END INIT INFO
#


#source some script files in order to set and export environmental variables
#as well as add the appropriate executables to $PATH
export JAVA_HOME=/usr
export PATH=$JAVA_HOME/bin:$PATH
export JBOSS_HOME=/usr/local/share/jboss/current
export PATH=$JBOSS_HOME/bin:$PATH
JBOSS_HOST="0.0.0.0"

case "$1" in
	start)
		echo "Starting JBoss"
	    start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/standalone.sh
		;;

	stop)
		echo "Stopping JBoss"
        start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/jboss-admin.sh -- --connect command=:shutdown
		;;

	restart)
		echo "Restarting JBoss"
        start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/jboss-cli.sh -- --connect command=:shutdown
	    start-stop-daemon --start --quiet --background --chuid jboss --exec ${JBOSS_HOME}/bin/standalone.sh
		;;

	*)
		echo "Usage: /etc/init.d/jboss {start|stop|restart}"
		exit 1
		;;
esac
exit 0
