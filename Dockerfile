FROM neo4j:3.0-enterprise

COPY start.sh /start.sh

EXPOSE 5001 6001

ENTRYPOINT ["/start.sh"]

CMD ["cluster"]