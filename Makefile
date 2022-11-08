version:
	echo "$(shell ruby -v)"

.PHONY: version mac server

mac:
	brew install chruby ruby-install xz
	ruby-install ruby
	@# echo "source $(shell brew --prefix)/opt/chruby/share/chruby/chruby.sh" >> ~/.zshrc
	@# echo "source $(shell brew --prefix)/opt/chruby/share/chruby/auto.sh" >> ~/.zshrc
	@# echo "chruby ruby-3.1.2" >> ~/.zshrc # run 'chruby' to see actual version
	cmd="source $(shell brew --prefix)/opt/chruby/share/chruby/chruby.sh"; grep -qxF "$${cmd}" ~/.zshrc || echo "$${cmd}" >> ~/.zshrc
	cmd="source $(shell brew --prefix)/opt/chruby/share/chruby/auto.sh"; grep -qxF "$${cmd}" ~/.zshrc || echo "$${cmd}" >> ~/.zshrc
	cmd="chruby ruby-3.1.2"; grep -qxF "$${cmd}" ~/.zshrc || echo "$${cmd}" >> ~/.zshrc
	exec zsh
	ruby -v
	if [[ $(shell ruby -v | awk '{print $$2}') != "3."* ]]; then echo "no ruby3"; exit 1; fi
	gem install jekyll
	bundle install
	bundle add webrick

server:
	bundle exec jekyll serve
