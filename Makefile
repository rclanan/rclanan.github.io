CHECK=✔
HR=\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#\#

all: update build

build:
	@echo "${HR}"
	@echo "Building assets..."
	@echo "${HR}"
	@recess --compress _assets/styles.less > css/styles.css
	@echo "Compiling and Compressing Less and CSS files with Recess... ${CHECK} Done"
	@cat _assets/bootstrap/js/*.js > js/scripts.js.tmp
	@cat _assets/scripts.js >> js/scripts.js.tmp
	@uglifyjs js/scripts.js.tmp > js/scripts.js
	@rm -rf js/scripts.js.tmp
	@echo "Compiling and Compressing JS files with uglify-js... ${CHECK} Done"
	@echo "${HR}"
	@cp -r _site/tags/* tags/
	@echo "Copying tags folder to root... ${CHECK} Done"
	@echo "${HR}"
	@echo "Successfully built."

update:
	./script/update

