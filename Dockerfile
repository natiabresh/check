FROM cs50/baseimage:deprecated

USER root

# install dev version of check50
RUN git clone -b check50api-pool https://github.com/cs50/check50.git /tmp/check50 && \
    pip install -U /tmp/check50

# install Python packages
RUN pip3 install \
        flask_sqlalchemy \
        nltk \
        passlib \
        pytz && \
    python3 -m nltk.downloader -d /usr/share/nltk_data/ punkt

# check50 wrapper
COPY ./check50-wrapper /usr/local/bin/
RUN chmod a+x /usr/local/bin/check50-wrapper

USER ubuntu

# clone checks
RUN git clone -b master https://github.com/cs50/checks.git ~/.local/share/check50/cs50/checks/

# configure git
RUN git config --global user.name bot50 && \
    git config --global user.email bot@cs50.harvard.edu
