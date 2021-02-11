# Go-Go-Gadget-Gospel

------------------------------------------------------------------------------------
#### Table of Contents
- [Pre-Requisites](#prereq)
- [Quick Start](#quick)
- [Setting up Git Hosting](#githost)
- [Setting up Jenkins](#jenkins)
- [Setting up a Build Pipeline with Jenkins](#buildjenkins)
	- [C](#clang)
	- [C++](#cplus)
	- [Go](#golang)
	- [.NET](#netlin)
	- [Nim](#nim)
	- [PowerShell](#pslang)
	- [Python](#pylang)
	- [Rust](#rustlang)

------------------------------------------------------------------------------------
#### What is this?
- Simple CI/CD setup for Jenkins using Docker + containers.
- End result is a Jenkins Master, running in a docker container, based off the 'Official' container image, with build-agents/slaves available for instantiation on Windows or Linux, also using docker/containers.
	* Master instance is pre-configured with several plugins, so that if desired, you can spin up the Master instance and build locally, if you don't need Windows.

------------------------------------------------------------------------------------
#### Why?
1. Make it easier to get started with CI/CD tooling for non-developers.
2. Allow for simple setup/teardown of CI/CD infra for testing and engagements.

------------------------------------------------------------------------------------
#### Why do I care?
- See inspirations.

------------------------------------------------------------------------------------
#### <a name="prereq">Pre-requisites</a>
0. CI/CD 
	- [What is CI/CD? - Opensource.com](https://opensource.com/article/18/8/what-cicd)
1. Docker 
	- [Docker FAQ](https://docs.docker.com/engine/faq/)
2. Jenkins 
	- [Jenkins User Documentation](https://www.jenkins.io/doc/)
	- [Jenkins tutorialspoint](https://www.tutorialspoint.com/jenkins/jenkins_overview.htm)
	- Jenkins Pipelines
		- [Pipeline as Code with Jenkins(jenkins.io)](https://www.jenkins.io/solutions/pipeline/)
		- [Getting Started with Pipeline](https://www.jenkins.io/doc/book/pipeline/getting-started)
		- [Using a Jenkinsfile - jenkins.io](https://www.jenkins.io/doc/book/pipeline/jenkinsfile/)
		- [Creating your first Pipeline - jenkins.io](https://www.jenkins.io/doc/pipeline/tour/hello-world/)
		- [Pipeline Syntax - jenkins.io](https://www.jenkins.io/doc/book/pipeline/syntax/)
		- [Pipeline Steps Reference - jenkins.io](https://www.jenkins.io/doc/pipeline/steps/)
		- [Pipeline Examples - jenkins.io](https://www.jenkins.io/doc/pipeline/examples/)
		- [Running multiple steps - jenkins.io](https://www.jenkins.io/doc/pipeline/tour/running-multiple-steps/)
	- [Jenkins Jobs DSL](https://plugins.jenkins.io/job-dsl/)
		* `"Job DSL was one of the first popular plugins for Jenkins which allows managing configuration as code and many other plugins dealing with this aspect have been created since then, most notably the Jenkins Pipeline and Configuration as Code plugins. It is important to understand the differences between these plugins and Job DSL for managing Jenkins configuration efficiently. Jenkins Pipeline is often the better choice for creating complex automated processes. Job DSL can be used to create Pipeline and Multibranch Pipeline jobs. Do not confuse Job DSL with Pipeline DSL, both have their own syntax and scope of application. The Configuration as Code plugin can be used to manage the global system configuration of Jenkins. It comes with an integration for Job DSL to create an initial set of jobs."`
			* The casc plugin is already setup/installed in the base/master image.
		- [Job DSL Plugin](https://plugins.jenkins.io/job-dsl/)
3. Containers on Windows
	- 101/Getting Started Documentation:
		- [Containers on Windows documentation - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/)
		- [Windows container requirements - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/deploy-containers/system-requirements)
		- [Get started: Prep Windows for containers - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/quick-start/set-up-environment)
		- [Frequently asked questions about containers - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/about/faq)
			- See air-gap usage of Windows containers
				- [dockerd daemon - docs.docker.com](https://docs.docker.com/engine/reference/commandline/dockerd/)
					- Search for `Allow push of nondistributable artifacts` in the above link
		- [Dockerfile on Windows - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-docker/manage-windows-dockerfile)
		- [Isolation Modes - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/hyperv-container)
	- Windows Containers
		- [Container Base Images - docs.ms](https://docs.microsoft.com/en-us/virtualization/windowscontainers/manage-containers/container-base-images)
		- [Windows Nano Server Container Image - hub.docker](https://hub.docker.com/_/microsoft-windows-servercore)
		- [Windows Server Core Container Image - hub.docker](https://hub.docker.com/_/microsoft-windows-servercore)
		- [Windows Docker Agent Images: General Availability - jenkins.io(2020)](https://www.jenkins.io/blog/2020/05/11/docker-windows-agents/)

------------------------------------------------------------------------------------
#### <a name="quick">Quick Start</a>
1. **Install Docker**
2. **Clone repo**
	- `git clone https://github.com/rmusser01/Go-Go-GadgetGospel`
3. **Build + Run 'Master' Jenkins instance**
	- Move into cloned directory and build initial master
		- `cd ./Master/ && docker build -t jenkins:Master -f ./J-LTS.Dockerfile .`
	- With Persistence: 
		* `docker run --name jenkins -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:master-1`
	- No Persistence: 
		* `docker run --name jenkins --rm -p 8080:8080 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:master-1`
4. **Build + Run the 'Slave' Jenkins Instance**
	- **Linux**
		- Move into Build-Agents Folder and Build container:
			* `cd ./Build-Agents/Linux/ && docker build -t jenkins:U18LTS -f ./U18LTS.Dockerfile .`
		- Run the Build-Agent with No Persistence:
			- `docker run --name JB-L-1 --rm -d -ti -p 12390:22 -v /var/jenkins_home --env JENKINS_ADMIN_ID=admin --env JENKINS_ADMIN_PASSWORD=password jenkins:U18LTS`
				- `--rm` - remove after execution
				- `-d` - run as daemon
				- `-t` - `Allocate a pseudo-tty`
				- `-i` - Keep STDIN open even if not attached
				- `-p` - set external:internal port mapping (External SSH is over port `12390`)
		- Verify it's working:
			* `ssh jenkins@<IP_HERE> -p 12390`
			* password: `jenkins`
	- **Windows**
		- In order to use containers on Windows, you'll need docker installed, along with Hyper-V. This assumes you've already done the prep work.
		- Building Locally from Scractch:
			- Move into Build-Agents Folder and build the Windows build-agent container:
				* `cd ./Build-Agents/Windows/ && docker build -t <FIXME> -f ./<FIXME> .`
			- Run the Build-Agent with No Persistence:
				- `docker run --name <FIXME>`
			- Verify it's working:
				- `<FIXME>`
		- Building Locally from Jenkins images:
			- Move into the appropriate Build-Agents Folder:
				- `cd ./Build-Agents/Windows/`
			- Build 
		- Pulling from the Docker Public Registry and using the official Jenkins Docker image for Slaves/Build-Agents.
			- Pull from Registry:
				- Jenkins Agent Docker image (jenkinsci/slave/)
					- https://hub.docker.com/r/jenkinsci/slave/
					- `docker pull jenkinsci/slave`
				- Docker image for Jenkins agents connected over SSH (jenkinsci/ssh-agent)
					- https://hub.docker.com/r/jenkins/ssh-agent
					- `docker pull jenkinsci/slave` docker run jenkins/ssh-agent "<public key>"

			- On the master, set up the new build-agent/slave and then configure the `Remote root directory` to `C:\Users\jenkins\Agent`
			- 'Normal' agent Docker machine:
				- `docker run -i --rm --name agent --init jenkins/agent:windowsservercore-ltsc2019-jdk11 java -jar C:/ProgramData/Jenkins/agent.jar`
			- SSH-Agent
				- `docker run jenkins/ssh-agent:windowsservercore-ltsc2019-jdk11 "<public key>"` 
					- `<public key>` being the SSH public key of your master server/instance.
5. **Configure the Build-Agent(s) on the Master instance of Jenkins:**
	- There are several different means of having Agents/Slaves communicate with the master instance.
		- SSH
			...if following above instructions.
				* Need to manually copy SSH public key from master to slave agent's `~/.ssh/authorized_keys` file.
		- Docker
			...if you want to instead follow the strategy of having a Jenkins master, which can call out to a pre-provisioned/configured Docker host, which can then launch docker containers to act as build-agents on command.
		- JNLP
			- Requires GUI interaction.
		- WMI/DCOM
			...if you're using Windows.
6. **OPTIONAL: Setup self-hosted git instance.**
	* **Using Gitea from repo:**
		* Create a docker Volume for persistence:
			* `docker volume create gitea`
		* Build and Run the Image:
			* `cd ./Supporting/Git/ && chmod 775 Run-Tea.sh & ./Run-Tea.sh`
		* Or just pull and run a prebuilt from a Registry: https://hub.docker.com/r/gitea/gitea/
			* `docker run --name Git-Tea -p 11001:3000 -p 11002:22 -v gitea:/data --env USER_UID=1000 --env USER_GID=1000 gitea:latest`
		* Finish setting up by visiting `localhost:11001`, or the IP of the machine exposing the docker instance.
7. **Get to building/testing!**


------------------------------------------------------------------------------------
#### <a name="githost">Setting up Git Hosting</a>
* **Using Gitea**
	* **Documentation**
		* [Gitea](https://github.com/go-gitea/gitea)
		* [Gitea with Docker](https://docs.gitea.io/en-us/install-with-docker-rootless/)
	* **Setup**
		* Create a docker Volume for persistence:
			* `docker volume create gitea`
		* Build and Run the Image:
			* `cd ./Supporting/Git/ && chmod 775 Run-Tea.sh & ./Run-Tea.sh`
		* Or just pull and run a prebuilt from a Registry: https://hub.docker.com/r/gitea/gitea/
			* `docker run --name Git-Tea -p 11001:3000 -p 11002:22 -v gitea:/data --env USER_UID=1000 --env USER_GID=1000 gitea:latest`
		* Finish setting up by visiting `localhost:11001`, or the IP of the machine exposing the docker instance.


------------------------------------------------------------------------------------
### <a name="jenkins"> Instructions on Setting up Jenkins</a>
1. Install Docker.
2. Run/Launch Master
	- See Run.sh
3. Configure Master
	- Additional users
	- User permissions
		- FIXME - Matrix plugin
	- Plugins (Updates and adding 'Docker')
		- SSH
			* Need to manually copy SSH public key from master to slave agent's `~/.ssh/authorized_keys` file.
			* [SSH-Slaves](https://github.com/jenkinsci/ssh-slaves-plugin/blob/master/doc/CONFIGURE.md)
			* []Docker-SSH-Agent](https://github.com/jenkinsci/docker-ssh-agent)
	- Fix hostname
	- Agents & Distributed Builds
		* [Using Jenkins agents - Jenkins.io](https://www.jenkins.io/doc/book/using/using-agents/)
		* [Distributed builds - Jenkins wiki](https://wiki.jenkins.io/display/JENKINS/Distributed+builds)
3. Run/Launch Slave-1
	- See Build_Plain_Runner.sh
4. Configure Slave on Master
	- See here [How to Configure Docker Container as Build Slaves for Jenkins - Naren Chejara](https://narenchejara.medium.com/how-to-configure-docker-container-as-build-slaves-for-jenkins-d7795f78402d) for a guide on using Docker to host your build-slave and being able to instantiate it from the 'Master' instance.

------------------------------------------------------------------------------------
### <a name="buildjenkins"> Setting up a Build Pipeline with Jenkins</a>
* **Setting up a pipeline for C (Linux & Windows)**<a name="clang"></a>
	* You should be able to handle it.
* **Setting up a pipeline for C++ (Linux & Windows)**<a name="cplus"></a>
	* [C++](https://www.jenkins.io/blog/2017/07/07/jenkins-conan/)
* **Setting up a pipeline for Go (Linux & Windows)**<a name="golang"></a>
	* [Go](https://www.jenkins.io/doc/pipeline/tour/hello-world/#go)
* **Setting up a pipeline for Java**<a name="javalang"></a>
	* [Java](https://www.jenkins.io/doc/pipeline/tour/hello-world/#java)
* **Setting up a pipeline for .NET (Linux & Windows)**<a name="netlin"></a>
	* [.NET (Linux)](https://medium.com/@babaknia/build-net-core-projects-with-jenkins-for-linux-63a16f2a3414)
* **Setting up a pipeline for .NET (Windows)**<a name="netwin"></a>
	* [.NET (Windows)](https://www.c-sharpcorner.com/article/continuous-deployment-with-jenkins-and-net/)
* **Setting up a pipeline for Nim**<a name="nimlang"></a>
	* [Nim](https://github.com/nim-lang/Nim)
* **Setting up a pipeline for PowerShell (Windows)**<a name="pslang"></a>
	* [PowerShell(2017)](https://www.jenkins.io/blog/2017/07/26/powershell-pipeline/)
* **Setting up a pipeline for Python (Linux & Windows)**	<a name="pylang"></a>
	* [Python](https://www.jenkins.io/doc/pipeline/tour/hello-world/#python)
* **Setting up a pipeline for Rust**<a name="rustlang"></a>
	* [Rust](https://fuzzyblog.io/blog/cicd/2020/06/05/setting-up-ci-cd-with-jenkins-blue-ocean-github-for-a-rust-program.html)

------------------------------------------------------------------------------------
#### Inspirations
* **Articles**
	* [Jenkins - More than Just Target Practice - FortyNorth Security](https://fortynorthsecurity.com/blog/jenkins-more-than-just-target-practice/)
	* [Using Azure Pipelines to validate my Sysmon configuration - Olaf Harton(2020)](https://medium.com/falconforce/using-azure-pipelines-to-validate-my-sysmon-configuration-48315dba7571)
	* [Testing your RedTeam Infrastructure - Adam Chester(2020)](https://blog.xpnsec.com/testing-redteam-infra/)
		* In this post I'm going to start with a quick review of how RedTeam infrastructure is defined in code which would typically live in a Git repo somewhere. More importantly however, we will continue this by looking at ways in which our environments can be tested as they evolve and increase in complexity, finishing with a walkthrough of how we can introduce a CI pipeline into the mix to help automate this testing.
* **Talks**
	* [Offensive Development: How To DevOps Your Red Team - Dominic Chell(BSidesMCR2019)](https://www.youtube.com/watch?v=n5_V61NI0tA)
	* [OffSecOps – Will Schroeder (SO-CON 2020)](https://www.youtube.com/watch?v=XaICChBJMck&list=PLJK0fZNGiFU-2vFpjnt96j_VSuQVTkAnO&index=2)
		* As the offensive industry continues to mature in reaction to the progression of its defensive counterpart, offensive teams have increasingly integrated DevOps practices to mature their operations. In this talk, we'll describe our approach to building an offensive continuous integration (CI) pipeline, including our architecture and lessons learned. We'll show how tracking of (unique) artifacts per engagement, proactive scanning for artifacts submitted by defenders to cloud analysis platforms, integrated obfuscation, OPSEC scanning of artifacts, and seamless integration of the build process into existing C2 frameworks (like Cobalt Strike) can all be accomplished with free installations of Jenkins and Artifactory on your own (non-cloud) hardware. Come learn how to up your artifact game!
	* [Offensive Development: Post Exploitation Tradecraft in an EDR World - Dominic Chell(x33fCon2020)](https://www.youtube.com/watch?v=GHmOJhpMw_o)
		* You spend days or even weeks perfecting the perfect phish; your campaign has a targeted pre-text, a slick initial access payload and it slips through perimeter defences right in to your target's inbox. Moments later, your C2 pings and your beacon is awake - you're in, it's time to explore! You start by probing the endpoint, checking your privileges and getting your bearings in the network. Suddenly, silence... your beacon has stopped responding, your infrastructure is burned and you have to start over.  Command line logging, PowerShell logging, sysmon, EDR, EDP, app whitelisting, AMSI, the blue team has it all and you're playing on their turf. Unless your post-exploitation game is at it's peak, you shall not pass.  During this talk we will explore post-exploitation tradecraft, reviewing the opsec pitfalls that commonly lead to detection in mature environments as well as how to significantly reduce the indicators of compromise. It will demonstrate how DevOps principles can be applied to red teaming, focusing on the implementation of a custom CI/CD pipeline to automatically consume, build and deploy existing and custom tooling to an environment in a manner agnostic to any command and control framework. This approach also provides the operator with the capability to programmatically and automatically protect their tools from DFIR, safeguarding intellectual property and operational infrastructure when an artifact is dropped to disk.  The future of red teaming is offensive development.
* `+` Others






