# 🐳 Introduction to Containers with Podman

> ## 📘 Overview
> Learn the fundamentals of containerization and how to use Podman to create, manage, inspect, and troubleshoot containers on Linux systems.

---

# 🎯 Objectives

By the end of this lab, students will be able to:

✅ Understand the fundamentals of containerization technology  
✅ Install and configure Podman on a Linux system  
✅ Create and manage container images using Podman  
✅ Start, stop, and inspect containers effectively  
✅ Perform basic container lifecycle management operations  
✅ Understand the differences between Podman and other container runtimes  

---

# 📚 Prerequisites

Before starting this lab, students should have:

🔹 Basic knowledge of Linux command-line operations  
🔹 Understanding of file systems and directory structures  
🔹 Familiarity with package management concepts  
🔹 Basic networking concepts  
🔹 Access to a terminal or command-line interface  

---

# 🖥️ Lab Environment

## ☁️ Ready-to-Use Cloud Machines

Al Nafi provides pre-configured Linux-based cloud machines for this lab.

### 🧰 Your Environment Includes

- 🐧 CentOS Stream 9 or RHEL 9 compatible system
- 🔑 Root access for package installation
- 🌐 Internet connectivity for downloading images
- 📦 Pre-configured repositories for Podman installation

---

# 🚀 Task 1: Install Podman and Create Containers

---

# 🔹 Subtask 1.1: Install Podman

Podman is a daemonless container engine that provides a Docker-compatible command-line interface.

---

## 🛠️ Tool: `dnf`

Update system packages:

```bash
sudo dnf update -y
```

---

## 🛠️ Tool: `dnf`

Install Podman:

```bash
sudo dnf install -y podman
```

---

## 🛠️ Tool: `podman`

Verify installation:

```bash
podman --version
```

✅ Expected output:

```text
podman version 4.x.x
```

---

## 🛠️ Tool: `podman`

Check Podman system information:

```bash
podman system info
```

This command displays detailed information about your Podman installation and system configuration.

---

# 🔹 Subtask 1.2: Create Your First Container

---

## 🛠️ Tool: `podman`

Pull and run an NGINX container:

```bash
podman run -d --name my-nginx -p 8080:80 docker.io/nginx:latest
```

---

# 📖 Command Breakdown

| 🔖 Option | 📘 Description |
|---|---|
| run | Creates and starts a container |
| -d | Runs container in background |
| --name | Assigns a container name |
| -p 8080:80 | Maps host port to container port |
| docker.io/nginx:latest | Image used for container |

---

## 🛠️ Tool: `podman`

Verify container is running:

```bash
podman ps
```

✅ You should see the container status as **Up**.

---

## 🛠️ Tool: `curl`

Test the web server:

```bash
curl http://localhost:8080
```

✅ You should see the default NGINX welcome page HTML.

---

# 🔹 Subtask 1.3: Create a Custom Container

---

## 🛠️ Tool: `podman`

Run a Python HTTP server container:

```bash
podman run -d --name python-server -p 8081:8000 docker.io/python:3.9-slim sh -c "python -m http.server 8000"
```

---

## 🛠️ Tool: `podman`

Verify running containers:

```bash
podman ps
```

✅ You should now see two running containers.

---

# 📦 Task 2: Manage Container Images

---

# 🔹 Subtask 2.1: List and Inspect Images

---

## 🛠️ Tool: `podman`

List downloaded images:

```bash
podman images
```

---

## 🛠️ Tool: `podman`

Inspect an image:

```bash
podman inspect docker.io/nginx:latest
```

This command displays image metadata including layers, environment variables, and configuration.

---

## 🛠️ Tool: `podman`

View image history:

```bash
podman history docker.io/nginx:latest
```

---

# 🔹 Subtask 2.2: Search and Pull Images

---

## 🛠️ Tool: `podman`

Search for Apache HTTP server images:

```bash
podman search httpd
```

---

## 🛠️ Tool: `podman`

Pull a specific image:

```bash
podman pull docker.io/httpd:2.4
```

---

## 🛠️ Tool: `podman`

Pull Alpine Linux image:

```bash
podman pull docker.io/alpine:3.18
```

---

## 🛠️ Tool: `podman`

Verify downloaded images:

```bash
podman images
```

---

# 🔹 Subtask 2.3: Remove Images

---

## 🛠️ Tool: `podman`

Remove an unused image:

```bash
podman rmi docker.io/httpd:2.4
```

---

## 🛠️ Tool: `podman`

Remove multiple images:

```bash
podman rmi docker.io/alpine:3.18 docker.io/python:3.9-slim
```

> ⚠️ Images currently used by running containers cannot be removed.

---

# 🔄 Task 3: Start, Stop, and Inspect Containers

---

# 🔹 Subtask 3.1: Container Lifecycle Management

---

## 🛠️ Tool: `podman`

List all containers:

```bash
podman ps -a
```

---

## 🛠️ Tool: `podman`

Stop a container:

```bash
podman stop my-nginx
```

---

## 🛠️ Tool: `podman`

Start a container:

```bash
podman start my-nginx
```

---

## 🛠️ Tool: `podman`

Restart a container:

```bash
podman restart my-nginx
```

---

## 🛠️ Tool: `podman`

Pause and unpause a container:

```bash
podman pause my-nginx
podman unpause my-nginx
```

---

# 🔹 Subtask 3.2: Inspect Container Details

---

## 🛠️ Tool: `podman`

Inspect container information:

```bash
podman inspect my-nginx
```

---

## 🛠️ Tool: `podman`

View container logs:

```bash
podman logs my-nginx
```

---

## 🛠️ Tool: `podman`

Follow logs in real-time:

```bash
podman logs -f my-nginx
```

Press `Ctrl + C` to stop following logs.

---

## 🛠️ Tool: `podman`

View resource usage:

```bash
podman stats my-nginx
```

Press `Ctrl + C` to exit.

---

# 🔹 Subtask 3.3: Execute Commands in Running Containers

---

## 🛠️ Tool: `podman`

Execute command inside container:

```bash
podman exec my-nginx ls -la /usr/share/nginx/html
```

---

## 🛠️ Tool: `podman`

Start interactive shell session:

```bash
podman exec -it my-nginx /bin/bash
```

Inside container:

```bash
cat /etc/nginx/nginx.conf
exit
```

---

## 🛠️ Tool: `echo`

Create a file on host:

```bash
echo "Hello from host" > test.txt
```

---

## 🛠️ Tool: `podman`

Copy file into container:

```bash
podman cp test.txt my-nginx:/usr/share/nginx/html/
```

---

## 🛠️ Tool: `curl`

Verify copied file:

```bash
curl http://localhost:8080/test.txt
```

---

# 🔹 Subtask 3.4: Container Cleanup

---

## 🛠️ Tool: `podman`

Stop all running containers:

```bash
podman stop $(podman ps -q)
```

---

## 🛠️ Tool: `podman`

Remove containers:

```bash
podman rm my-nginx python-server
```

---

## 🛠️ Tool: `podman`

Remove all stopped containers:

```bash
podman container prune
```

---

## 🛠️ Tool: `podman`

Remove unused images:

```bash
podman image prune
```

---

# ⚙️ Advanced Container Operations

---

# 💽 Working with Volumes

---

## 🛠️ Tool: `podman`

Create volume:

```bash
podman volume create my-data
```

---

## 🛠️ Tool: `podman`

Run container with volume:

```bash
podman run -d --name data-container -v my-data:/data docker.io/alpine:latest sleep 3600
```

---

## 🛠️ Tool: `podman`

List volumes:

```bash
podman volume ls
```

---

# 🌐 Container Networking

---

## 🛠️ Tool: `podman`

Create custom network:

```bash
podman network create my-network
```

---

## 🛠️ Tool: `podman`

Run containers on custom network:

```bash
podman run -d --name web1 --network my-network docker.io/nginx:latest
podman run -d --name web2 --network my-network docker.io/nginx:latest
```

---

## 🛠️ Tool: `podman`

Test connectivity between containers:

```bash
podman exec web1 ping web2
```

---

# 🛑 Troubleshooting Tips

---

# ❗ Common Issues and Solutions

## 🔒 Permission Denied Errors

✅ Ensure proper permissions or use `sudo`  
✅ Check SELinux contexts if enabled  

---

## 🌐 Port Already in Use

✅ Use `podman ps` to identify conflicts  
✅ Choose different host ports  

---

## 📥 Image Pull Failures

✅ Check internet connectivity  
✅ Verify registry URLs  
✅ Try alternative registries  

---

## 🚫 Container Won't Start

✅ Check logs:

```bash
podman logs <container-name>
```

✅ Verify image compatibility with your architecture

---

# 🧪 Useful Troubleshooting Commands

## 🛠️ Tool: `podman`

View Podman events:

```bash
podman system events
```

---

## 🛠️ Tool: `podman`

View system information:

```bash
podman system info
```

---

## 🛠️ Tool: `podman`

Check disk usage:

```bash
podman system df
```

---

## 🛠️ Tool: `podman`

Reset Podman environment:

```bash
podman system reset
```

> ⚠️ Use with caution. This removes all containers, images, and volumes.

---

# ✅ Lab Verification

---

## 🛠️ Tool: `podman`

Check Podman version:

```bash
podman --version
```

---

## 🛠️ Tool: `podman`

Run hello-world container:

```bash
podman run --rm docker.io/hello-world
```

---

## 🛠️ Tool: `podman`

List containers:

```bash
podman ps -a
```

---

## 🛠️ Tool: `podman`

List images:

```bash
podman images
```

---

# 🎉 Conclusion

Congratulations! You have successfully completed the **Introduction to Containers with Podman** lab.

---

# 🧠 Key Achievements

✅ Installed and configured Podman  
✅ Created and managed containers  
✅ Worked with container images  
✅ Managed container lifecycle operations  
✅ Monitored logs and resource usage  
✅ Executed commands inside containers  
✅ Managed container networking and volumes  

---

# 🌍 Why This Matters

Containerization is a foundational technology in modern IT infrastructure and DevOps.

These skills are essential for:

- ☁️ Cloud-native applications
- 🔧 DevOps and CI/CD pipelines
- 🧩 Microservices architecture
- 🐧 Linux system administration
- 🏆 RHCSA certification preparation

---

# 🚀 Next Steps

✅ Build custom images using Containerfiles  
✅ Explore Kubernetes orchestration  
✅ Learn container security best practices  
✅ Study advanced networking and storage  
✅ Practice monitoring and logging solutions  
