FROM redash/redash:0.10.1.b1834

ENV PORT=5000 \
    REDASH_SERVER_WORKERS=4 \
    REDASH_CELERY_CONCURRENCY=16 \
    REDASH_CELERY_SCHEDULED_CONCURRENCY=4

COPY supervisord.conf /opt/redash/supervisord/supervisord.conf

RUN pip install --upgrade git+https://github.com/vitillo/PyHive.git@pretty

COPY cors-fix.diff /opt/redash/current

RUN patch -p1 < cors-fix.diff
