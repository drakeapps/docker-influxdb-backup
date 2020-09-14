FROM debian

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y cron influxdb


COPY copy.sh /code/copy.sh
COPY start.sh /code/start.sh

ARG CRON_FREQ="0 0 */1 * *"

# Copy hello-cron file to the cron.d directory
RUN echo "${CRON_FREQ} /usr/bin/flock /.backup.lock sh /code/copy.sh" > /etc/cron.d/crontab

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

# Apply cron job
RUN crontab /etc/cron.d/crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Write environment and start cron
ENTRYPOINT ["/code/start.sh"]
