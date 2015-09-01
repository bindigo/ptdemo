root_dir = /home/wubin/workspace/ptdemo
log_dir = $(root_dir)/log
log_file = ptdemo
log_ext = log
pid_file = $(log_dir)/ptdemo.pid
debug_strings = loopback:connector:soap

# for docker
USER=$(shell whoami)
CONTAINERNAME=ptdemo

.PHONY:
run:
	@rm -rf $(log_dir)/*
	@slc run --cluster cpus -d --pid $(pid_file) -l $(log_dir)/$(log_file).%w.%p.$(log_ext) --no-profile

.PHONY:
debug_log:
	@rm -rf $(log_dir)/*
	@DEBUG=$(debug_strings) slc run --cluster cpus -d -l $(log_dir)/$(log_file).$(log_ext) --no-profile

.PHONY:
debug:
	@rm -rf $(log_dir)/*
	@slc debug server/server.js

.PHONY:
status:
	@-slc runctl status

.PHONY:
restart:
	@slc runctl restart

.PHONY:
stop:
	@slc runctl stop

.PHONY:
up:
	@git pull

.PHONY:
ci:
	@git add . && git commit && git push

build:
	docker build -t $(USER)/$(CONTAINERNAME) .
rebuild:
	docker build --no-cache -t $(USER)/$(CONTAINERNAME) .
destroy:
	docker stop $(CONTAINERNAME) 
	docker rm $(CONTAINERNAME) 
#run: 
	#docker run -d -p 3000:3000 --name $(CONTAINERNAME) $(USER)/$(CONTAINERNAME) 
#debug: 
	#docker exec -it $(CONTAINERNAME) /bin/bash
#start: 
	#docker start $(CONTAINERNAME) 
#stop: 
	#docker stop $(CONTAINERNAME) 
#logs: 
	#docker logs -f $(CONTAINERNAME) 

.PHONY:
clean:
	@rm -rf log/*
