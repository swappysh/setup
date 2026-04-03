.PHONY: install_gitconfig setup_git

setup_git: install_gitconfig

install_gitconfig:
	@repo_root="$$(pwd)"; \
	target="$$HOME/.gitconfig"; \
	if [ -L "$$target" ] && [ "$$(readlink "$$target")" = "$$repo_root/.gitconfig" ]; then \
		echo "✓ gitconfig already linked"; \
	elif [ -L "$$target" ]; then \
		rm "$$target"; \
		ln -s "$$repo_root/.gitconfig" "$$target"; \
		echo "✓ replaced existing gitconfig symlink"; \
	elif [ -e "$$target" ]; then \
		backup="$$target.backup-$$(date +%Y%m%d%H%M%S)"; \
		mv "$$target" "$$backup"; \
		ln -s "$$repo_root/.gitconfig" "$$target"; \
		echo "✓ backed up existing gitconfig and linked repo copy"; \
	else \
		ln -s "$$repo_root/.gitconfig" "$$target"; \
		echo "✓ linked repo gitconfig"; \
	fi
