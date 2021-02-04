# Go-Go-GadgetGospel

#### What is this?
- Simple CI/CD setup for Jenkins using Docker + containers.

#### Why?
1. Make it easier to get started with CI/CD tooling for non-developers.
2. Allow for simple setup/teardown of CI/CD infra for testing and engagements.

#### Why do I care?
- See inspirations.

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
* + Others

#### Pre-requisites
0. CI/CD 
	- [What is CI/CD? - Opensource.com](https://opensource.com/article/18/8/what-cicd)
1. Docker 
	- [Docker FAQ](https://docs.docker.com/engine/faq/)
2. Jenkins 
	- [Jenkins User Documentation](https://www.jenkins.io/doc/)
	- [Jenkins tutorialspoint](https://www.tutorialspoint.com/jenkins/jenkins_overview.htm)
	- [Pipeline as Code with Jenkins(jenkins.io)](https://www.jenkins.io/solutions/pipeline/)


### Jenkins 
1. Install Docker.
2. Run/Launch Master
	- See Run.sh
3. Configure Master
	- Additional users
	- User permissions
	- Plugins (Updates and adding 'Docker')
	- Fix hostname
	- Other stuff
3. Run/Launch Slave-1
	- See Build_Plain_Runner.sh
4. Configure Slave on Master
	- See here [How to Configure Docker Container as Build Slaves for Jenkins - Naren Chejara]( https://narenchejara.medium.com/how-to-configure-docker-container-as-build-slaves-for-jenkins-d7795f78402d) for a guide on using Docker to host your build-slave and being able to instantiate it from the 'Master' instance.
