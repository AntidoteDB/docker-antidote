FROM erlang:21

LABEL maintainer="ilyas@toumlilt.com"

# --------
# Setup
# --------

# git repostiroy to be used
ENV ANTIDOTE_REPO "https://github.com/AntidoteDB/antidote"

# TARGET can be a branch name or release tag
ENV ANTIDOTE_REPO_TARGET "v0.2.1"

# clone into antidote-src directory
RUN git clone -b "${ANTIDOTE_REPO_TARGET}" --single-branch --depth 1 "${ANTIDOTE_REPO}" /antidote-src
RUN cd /antidote-src && make rel
RUN cp -R /antidote-src/_build/default/rel/antidote /antidote/
RUN rm -rf antidote-src
# use short names instead of fully qualified names
RUN sed -ie 's/-name/-sname/' /antidote/releases/0.2.1/vm.args.src

# Configurable antidote parameters

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
    -antidote_stats metrics_port ${METRICS_PORT} \
    -kernel inet_dist_listen_min ${ERLANG_DIST_PORT_MIN} \
    -kernel inet_dist_listen_max ${ERLANG_DIST_PORT_MAX}
