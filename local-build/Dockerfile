FROM erlang:24

LABEL maintainer="ilyas@toumlilt.com"

# --------
# Setup
# --------

ENV SRC_DIR "/usr/src/antidote"

# Choose to either use long names or short names for Erlang node via
# env variable SHORT_NAME_PREFIX
#  empty: long name
#  s    : short name
ENV SHORT_NAME_PREFIX "s"
#ENV SHORT_NAME_PREFIX ""

# copy antidote directory
COPY . ${SRC_DIR}
# make release
RUN cd ${SRC_DIR} && make rel
# copy release
RUN cp -R ${SRC_DIR}/_build/default/rel/antidote /antidote/
# delete source
RUN rm -rf ${SRC_DIR}

# Configurable antidote parameters


# --------
# Ring Parameter
# --------

# ring size, should be an exponent of 2
ENV RING_SIZE "16"


# --------
# Network
# --------

# intra-dc
ENV HANDOFF_PORT "8099"

# inter-dc ports
ENV LOGREADER_PORT "8085"
ENV PBSUB_PORT "8086"

# public client port
ENV PB_PORT "8087"
ENV PB_IP "0.0.0.0"

# metrics
ENV METRICS_PORT "3001"

# Erlang configuration

# (Short) Name of the node and cookie
# host name should be the container_name of the docker container
ENV NODE_NAME "antidote@antidote"
ENV COOKIE "secret"

# Expose protocol buffer client port
EXPOSE 8087


# --------
# Other Configuration
# --------

# verbosity of the logging
# debug, info, notice, warning, error, alert, critical
ENV DEBUG_LOGGER_LEVEL "info"

# where the logs and data are stored and exposed
ENV ROOT_DIR_PREFIX "/antidote-data/"
ENV DATA_DIR_PREFIX "data/"
ENV LOGGER_DIR_PREFIX "log/"


# --------
# Antidote Features Configuration
# Adjusting features for a node restart can have unexpected consequences
# Decide on features before first starting and operating the AntidoteDB node
# see config/sys.config.src for documentation
# --------
ENV ANTIDOTE_TXN_CERT "true"
ENV ANTIDOTE_TXN_PROT "clocksi"
ENV ANTIDOTE_RECOVER_FROM_LOG "true"
ENV ANTIDOTE_META_DATA_ON_START "true"
ENV ANTIDOTE_SYNC_LOG "false"
ENV ANTIDOTE_ENABLE_LOGGING "true"
ENV ANTIDOTE_AUTO_START_READ_SERVERS "true"


# shell form of entrypoint
ENTRYPOINT /antidote/bin/antidote foreground \
    -riak_core handoff_port ${HANDOFF_PORT} \
    -antidote txn_cert ${ANTIDOTE_TXN_CERT} \
    -antidote txn_prot ${ANTIDOTE_TXN_PROT} \
    -antidote recover_from_log ${ANTIDOTE_RECOVER_FROM_LOG} \
    -antidote recover_metadata_on_start ${ANTIDOTE_RECOVER_METADATA_ON_START} \
    -antidote sync_log ${ANTIDOTE_SYNC_LOG} \
    -antidote enable_logging ${ANTIDOTE_ENABLE_LOGGING} \
    -antidote auto_start_read_servers ${ANTIDOTE_AUTO_START_READ_SERVERS} \
    -antidote logreader_port ${LOGREADER_PORT} \
    -antidote pubsub_port ${PBSUB_PORT} \
    -ranch pb_port ${PB_PORT} \
    -riak_core ring_creation_size ${RING_SIZE} \
    -antidote_stats metrics_port ${METRICS_PORT} \
    -kernel logger_level ${DEBUG_LOGGER_LEVEL} \
    -kernel inet_dist_listen_min ${ERLANG_DIST_PORT_MIN} \
    -kernel inet_dist_listen_max ${ERLANG_DIST_PORT_MAX}
