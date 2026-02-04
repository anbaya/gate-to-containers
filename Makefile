all: 
	@mkdir -p /home/anbaya/data/mariadb
	@mkdir -p /home/anbaya/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean:
	@docker compose -f ./srcs/docker-compose.yml down -v
	@docker compose -f ./srcs/docker-compose-bonus.yml down -v
	@docker system prune -af

fclean: clean
	@rm -rf /home/anbaya/data/mariadb
	@rm -rf /home/anbaya/data/wordpress
	@rm -rf /home/anbaya/data/portainer

re: fclean all

bonus: 
	@mkdir -p /home/anbaya/data/mariadb
	@mkdir -p /home/anbaya/data/wordpress
	@mkdir -p /home/anbaya/data/portainer
	@docker compose -f ./srcs/docker-compose-bonus.yml up -d --build

.PHONY: all down re clean fclean