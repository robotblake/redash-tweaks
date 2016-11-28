FROM redash/redash:0.11.1.b2095

ENV PORT=5000 \
    REDASH_SERVER_WORKERS=4 \
    REDASH_CELERY_CONCURRENCY=16 \
    REDASH_CELERY_SCHEDULED_CONCURRENCY=8

COPY supervisord.conf /opt/redash/supervisord/supervisord.conf
COPY ssl/ /opt/redash/ssl/

RUN pip install --upgrade git+https://github.com/vitillo/PyHive.git@deployment#egg=pyhive

COPY cors-fix.diff /opt/redash/current
RUN patch -p1 < cors-fix.diff

COPY query-cancel.diff /opt/redash/current
RUN patch -p1 < query-cancel.diff
