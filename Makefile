deploy:
	ssh deploy@${HOST} -p ${PORT} 'docker network create --driver=overlay traefik-public || true'
	ssh deploy@${HOST} -p ${PORT} 'rm -rf traefik_${BUILD_NUMBER} && mkdir traefik_${BUILD_NUMBER}'
	scp -P ${PORT} docker-compose-production.yml deploy@${HOST}:traefik_${BUILD_NUMBER}/docker-compose.yml
	ssh deploy@${HOST} -p ${PORT} 'cd traefik_${BUILD_NUMBER} && docker stack deploy -c docker-compose.yml traefik'
