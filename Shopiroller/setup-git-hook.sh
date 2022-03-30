ln -s -f .hooks/pre-commit ../.git/hooks/pre-commit
git config core.hooksPath $(pwd)/.hooks
sudo chmod +x $(pwd)/.hooks
