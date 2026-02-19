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

setup_git:
	git config --global alias.delete-merged "\!f() { base=\"\$${1:-origin/main}\"; git fetch --prune >/dev/null 2>&1 || true; current=\"\$$(git branch --show-current)\"; merged_prs=\"\$$(gh pr list --state merged --limit 200 --json headRefName --jq '.[].headRefName' 2>/dev/null)\"; for b in \$$(git for-each-ref --format='%(refname:short)' refs/heads); do [ \"\$$b\" = \"\$$current\" ] && continue; case \"\$$b\" in trunk|main|master|develop) continue ;; esac; if git merge-base --is-ancestor \"\$$b\" \"\$$base\" 2>/dev/null; then git branch -d \"\$$b\"; continue; fi; if echo \"\$$merged_prs\" | grep -qx \"\$$b\"; then git branch -D \"\$$b\"; fi; done; }; f"
	@echo "✓ delete-merged alias installed. Usage: git delete-merged [base-ref]"

