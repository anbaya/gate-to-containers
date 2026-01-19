all: 
	@mkdir -p /home/anbaya/data/mariadb
	@mkdir -p /home/anbaya/data/wordpress
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

clean:
	@docker compose -f ./srcs/docker-compose.yml down -v
	@docker system prune -af

fclean: clean
	@rm -rf /home/anbaya/data/mariadb
	@rm -rf /home/anbaya/data/wordpress

re: fclean all

.PHONY: all down re clean fclean