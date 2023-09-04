FROM registry.access.redhat.com/ubi8/ubi-minimal

# Set a custom user and password via build arguments
#ARG SFTP_USER
#ARG SFTP_PASSWD

# Set environment variables for the user and password
#ENV SFTP_USER=$SFTP_USER
#ENV SFTP_PASSWD=$SFTP_PASSWD

# Install OpenSSH server
RUN microdnf install -y openssh-server && ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config

# Create SFTP user
#RUN useradd -m ${SFTP_USER} && echo "${SFTP_USER}:${SFTP_PASSWD}" | chpasswd
#RUN chown root. /home/${SFTP_USER}/ && chmod 755 /home/${SFTP_USER}/ && mkdir /home/${SFTP_USER}/upload && chown sftpuser. /home/${SFTP_USER}/upload/ && chmod 700 /home/${SFTP_USER}/upload/

RUN useradd -m sftpuser && echo 'sftpuser:r3dh4t1!' | chpasswd
RUN chown root. /home/sftpuser/ && chmod 755 /home/sftpuser/ && mkdir /home/sftpuser/upload && chown sftpuser. /home/sftpuser/upload/ && chmod 700 /home/sftpuser/upload/

# Expose port
EXPOSE 22

# Run SSH server
CMD [ "/usr/sbin/sshd","-D" ]

USER sftpuser
