review_rebase:
	chmod +x review_rebase.sh
	sudo mv review_rebase.sh /usr/local/bin/review_rebase

update_shell:
	# detect the shell
	if [ -n "$$ZSH_VERSION" ]; then \
		echo "Zsh"; \
		echo "source ~/.bashrc" >> ~/.zshrc; \
	elif [ -n "$$BASH_VERSION" ]; then \
		echo "Bash"; \
		echo "source ~/.bashrc" >> ~/.bashrc; \
	fi