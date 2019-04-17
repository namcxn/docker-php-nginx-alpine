exec_supervisord() {
    echo 'Start supervisord'
    exec /usr/bin/supervisord -n -c /etc/supervisord.conf
}

# Run helper function if passed as parameters
# Otherwise start supervisord
exec_supervisord
