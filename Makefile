deploy:
	ssh deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh deploy@${HOST} -p ${PORT} 'rm -rf traefik && mkdir traefik'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:traefik/docker-compose.yml
	ssh deploy@${HOST} -p ${PORT} 'cd traefik && docker stack deploy -c docker-compose.yml traefik'
